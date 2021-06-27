//
//  TodoDetailPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation

class TodoDetailPresenter: ObservableObject {
	struct Dependency {
		let updateTodoInteractor: AnyUseCase<Todo, Void, Never>
	}
	
	var todo: Todo?
	@Published var title: String = ""
	@Published var detail: String = ""
	@Published var finished: Bool = false
	
	private let dependency: Dependency
	
	init(dependency: Dependency, todo: Todo) {
		self.dependency = dependency
		self.todo = todo
		self.title = todo.title
		self.detail = todo.status!.detail
		self.finished = todo.status!.finished
	}

	func updateTodo(todo: Todo, completion: ((Result<Void, Error>) -> Void)? ) {
		dependency.updateTodoInteractor.execute(todo) { result in
			switch result {
				case .success:
					completion?(.success(()))
			}
		}
	}
	
}

#if DEBUG
extension TodoDetailPresenter {
	static let sample: TodoDetailPresenter = {
		let repository  = MockTodoRepository()
		let updateTodoInteractor = AnyUseCase(UpdateTodoInteractor(repository: repository))
		let dependency = TodoDetailPresenter.Dependency(
			updateTodoInteractor: updateTodoInteractor
		)
		return TodoDetailPresenter(dependency: dependency, todo: TodoMock.todoA1)
	}()
}

#endif
