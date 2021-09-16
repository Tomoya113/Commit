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
	@Published var sections: [SectionRealm] = []
}

protocol TodoListPresentation: ObservableObject {
	associatedtype DetailViewLink: View
	associatedtype TodoAddViewLink: View
	
	var displayData: DisplayData { get set }
	func onAppear()
	func onDismiss()
	func updateTodoStatus(todo: Todo)
	func deleteSection(_ index: Int)
	func detailViewLinkBuilder(for todo: Todo) -> DetailViewLink
	func todoAddViewLinkBuilder() -> TodoAddViewLink
}

class TodoListPresenter {
	struct Dependency {
		let listFetchInteractor: AnyUseCase<Void, [ListRealm], Never>
		let todoUpdateInteractor: AnyUseCase<Todo, Void, Never>
		let deleteSectionInteractor: AnyUseCase<SectionRealm, Void, Never>
		let wireframe: TodoListWireframe
	}
	
	@Published var displayData = DisplayData()
	private let dependency: Dependency

	private var notificationTokens: [NotificationToken] = []
	private var isFirstAppear: Bool = true
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	private func fetchList(completion: ((_ lists: [ListRealm]) -> Void)? ) {
		dependency.listFetchInteractor.execute(()) { result in
			switch result {
				case .success(let lists):
					completion?(lists)
			}
		}
	}
	
	private func refreshList() {
		fetchList { lists in
			self.updateList(lists: lists)
		}
	}
	
	private func updateList(lists: [ListRealm]) {
		setSection(from: lists)
		self.objectWillChange.send()
	}
	
	private func addNotificationTokens() {
		notificationTokens.append(displayData.lists[0].observe { change in
			switch change {
				case let .error(error):
					print(error.localizedDescription)
				default:
					self.refreshList()
			}
		})
	}

	private func setSection(from lists: [ListRealm]) {
		displayData.lists = lists
		let originSections = lists[0].sections
		displayData.sections = Array(originSections)
		print(originSections)
		objectWillChange.send()
	}
	
}

extension TodoListPresenter: TodoListPresentation {
	func onAppear() {
		// 初回のOnAppearの時だけ呼ばれて欲しい
		if isFirstAppear {
			self.isFirstAppear = false
			fetchList { lists in
				self.updateList(lists: lists)
				self.addNotificationTokens()
			}
		}
	}

	func onDismiss() {
		refreshList()
	}
	
	func updateTodoStatus(todo: Todo) {
		dependency.todoUpdateInteractor.execute(todo, completion: nil)
	}
	
	func deleteSection(_ index: Int) {
		if !displayData.lists.isEmpty {
//			displayData.currentSections.remove(at: index)
			dependency.deleteSectionInteractor.execute(displayData.lists[0].sections[index + 1], completion: nil)
		}
	}
	
	func detailViewLinkBuilder(for todo: Todo) -> some View {
		NavigationLink(destination: dependency.wireframe.generateDetailView(for: todo)) {
			TodoListRow(todo: todo) {
				self.updateTodoStatus(todo: todo)
				self.objectWillChange.send()
			}
		}
	}
	
	func todoAddViewLinkBuilder() -> some View {
		return (
			NavigationView {
				dependency.wireframe.generateTodoAddView()
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
				deleteSectionInteractor: deleteSectionInteractor,
				wireframe: TodoListRouter()
			)
			return TodoListPresenter(dependency: dependency)
		}()
	}
#endif
