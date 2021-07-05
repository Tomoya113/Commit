//
//  TodoAddPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation

class TodoAddPresenter: ObservableObject {
	struct Dependency {
		//		let listFetchInteractor: AnyUseCase<Void, [], Never>
		let todoCreateInteractor: AnyUseCase<AddTodoQuery, Void, Never>
	}
	@Published var title: String = ""
	@Published var subtitle: String = ""
	@Published var sectionIndex: Int = 0
	@Published var currentSectionId: String = ""
	@Published var currentTodoType: TodoTypes = .normal
	
	private let dependency: Dependency
	
	// ここにsection書くのよくなさそう
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	//	func
	
	func createNewTodo() {
		let query = AddTodoQuery(
			sectionId: currentSectionId,
			todo: Todo(
				title: title,
				detail: subtitle,
				displayTag: [],
				todoType: .normal)
			)
		dependency.todoCreateInteractor.execute(query) { result in
			switch result {
				case .success(()):
					print("success")
			}
		}
	}
}

#if DEBUG
extension TodoAddPresenter {
	static let sample: TodoAddPresenter = {
		let dependency = TodoAddPresenter.Dependency(
			todoCreateInteractor: AnyUseCase(TodoCreateInteractor(repository: MockTodoRepository())))
		return TodoAddPresenter(dependency: dependency)
	}()
}

#endif
