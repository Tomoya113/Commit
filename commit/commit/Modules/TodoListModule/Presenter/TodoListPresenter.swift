//
//  TodoListPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import Foundation
import RealmSwift
import SwiftUI

class DisplayData: ObservableObject {
	@Published var lists: [ListRealm] = []
	@Published var defaultSection: SectionRealm?
	@Published var currentSections: [SectionRealm] = []
}

class TodoListPresenter: ObservableObject {
	struct Dependency {
		let listFetchInteractor: AnyUseCase<Void, [ListRealm], Never>
		let todoUpdateInteractor: AnyUseCase<Todo, Void, Never>
		let deleteSectionInteractor: AnyUseCase<SectionRealm, Void, Never>
	}
	
	@Published var displayData = DisplayData()
	private let dependency: Dependency
	private let router: TodoListRouter = TodoListRouter()
	
	private var notificationTokens: [NotificationToken] = []
	private var isFirstAppear: Bool = true
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func onAppear() {
		if !isFirstAppear {
			return
		}
		self.isFirstAppear = false
		fetchList { lists in
			self.setSection(from: lists)
			self.objectWillChange.send()
			self.addNotificationTokens()
		}
	}
	
	private func fetchList(completion: ((_ lists: [ListRealm]) -> Void)? ) {
		dependency.listFetchInteractor.execute(()) { result in
			switch result {
				case .success(let lists):
					completion?(lists)
			}
		}
	}
	
	private func addNotificationTokens() {
		notificationTokens.append(displayData.lists[0].observe { change in
			switch change {
				case let .change(result, _):
					print("displayData.lists[0]")
					self.setSection(from: [result as! ListRealm])
				case let .error(error):
					print(error.localizedDescription)
				case .deleted:
					print("deleted")
			}
		})
		
		notificationTokens.append(displayData.defaultSection!.observe { change in
			switch change {
				case let .change(result, _):
					self.displayData.defaultSection = result as! SectionRealm
					// これが大事
					self.objectWillChange.send()
				case let .error(error):
					print(error.localizedDescription)
				case .deleted:
					print("deleted")
			}
		})
	}
	
	func onDismiss() {
		fetchList { result in
			self.setSection(from: result)
			self.objectWillChange.send()
		}
	}
	
	private func setSection(from lists: [ListRealm]) {
		// NOTE: 絶対ここでやるなよ???
		print("setSection")
		displayData.lists = lists
		let sections = lists[0].sections
		let defaultSection = sections[0]
		displayData.defaultSection = defaultSection
		if sections.count == 1 {
			return
		}
		let currentSections = sections[1..<sections.count]
		displayData.currentSections = Array(currentSections)
	}
	
	func updateTodoStatus(todo: Todo) {
		dependency.todoUpdateInteractor.execute(todo) { result in
			switch result {
				case .success:
					print("updated")
			}
		}
	}
	
	func deleteSection(_ index: Int) {
		if !displayData.lists.isEmpty {
			displayData.currentSections.remove(at: index)
			dependency.deleteSectionInteractor.execute(displayData.lists[0].sections[index + 1]) { result in
				switch result {
					case .success:
						print("delete")
				}
			}
		}
	}
		
	func generateTodoRow(todo: Todo) -> some View {
		TodoListRow(todo: todo) {
			let generator = UIImpactFeedbackGenerator(style: .light)
			generator.impactOccurred()
			self.updateTodoStatus(todo: todo)
			self.objectWillChange.send()
		}
	}
}

// Router周り
extension TodoListPresenter {
	func detailViewLinkBuilder<Content: View>(for todo: Todo, @ViewBuilder content: () -> Content) -> some View {
		NavigationLink(destination: router.generateDetailView(for: todo)) {
			content()
		}
	}
	
	func todoAddLinkBuilder() -> some View {
		return (
			NavigationView {
				router.generateTodoAddView()
			}
		)
	}
}

#if DEBUG
	extension TodoListPresenter {
		static let sample: TodoListPresenter = {
			let listFetchInteractor = AnyUseCase(ListFetchInteractor())
			let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor())
			let deleteSectionInteractor = AnyUseCase(DeleteSectionInteractor())
			let dependency = TodoListPresenter.Dependency(
				listFetchInteractor: listFetchInteractor,
				todoUpdateInteractor: todoUpdateInteractor,
				deleteSectionInteractor: deleteSectionInteractor
			)
			return TodoListPresenter(dependency: dependency)
		}()
	}
#endif
