//
//  TodoDetailPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation
import RealmSwift

class TodoDetailPresenter: ObservableObject {
	struct Dependency {
		let deleteTodoInteractor: AnyUseCase<Todo, Void, Never>
	}
	
	var todo: Todo
	private let dependency: Dependency
	
	init(dependency: Dependency, todo: Todo) {
		self.dependency = dependency
		self.todo = todo
	}
	
	func deleteTodo() {
		dependency.deleteTodoInteractor.execute(todo) { result in
			switch result {
				case .success:
					print("Delete")
			}
		}
	}
}

#if DEBUG
extension TodoDetailPresenter {	
	static let sample: TodoDetailPresenter = {
		let deleteTodoInteractor = DeleteTodoInteractor()
		let dependency = TodoDetailPresenter.Dependency(deleteTodoInteractor: AnyUseCase(deleteTodoInteractor))
		return TodoDetailPresenter(dependency: dependency, todo: TodoMock.todoA1)
	}()
}

#endif
