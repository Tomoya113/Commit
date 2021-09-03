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
	
	private var notificationTokens: [NotificationToken] = []
	private let dependency: Dependency
	private let router = TodoListRouter()
	private var isFirstAppear = false
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func onAppear() {
		dependency.listFetchInteractor.execute(()) { [weak self] result in
			switch result {
				case .success(let lists):
					self?.setSection(from: lists)
					self?.objectWillChange.send()
			}
		}
		
		notificationTokens.append(displayData.lists[0].observe { change in
			switch change {
				case let .change(result, _):
					self.setSection(from: [result as! ListRealm])
					self.objectWillChange.send()
				case let .error(error):
					print(error.localizedDescription)
				case .deleted:
					print("deleted")
			}
		})
	}
	
	func onDismiss() {
		dependency.listFetchInteractor.execute(()) { [weak self] result in
			switch result {
				case .success(let lists):
					self?.setSection(from: lists)
					self?.objectWillChange.send()
			}
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
		
	func generateTodoRow(todo: Todo, updateTodoStatus: @escaping  () -> Void) -> some View {
		TodoListRow(todo: todo) {
			let generator = UIImpactFeedbackGenerator(style: .light)
			generator.impactOccurred()
			print("update todo")
			updateTodoStatus()
		}
	}
	
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
