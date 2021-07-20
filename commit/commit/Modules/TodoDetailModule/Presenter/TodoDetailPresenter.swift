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
		let fetchSheetsCellInteractor: AnyUseCase<Todo, String, Never>
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
	
	func updateTodoIfNeeded() {
		if todo.type != .googleSheets {
			return
		}
		dependency.fetchSheetsCellInteractor.execute(todo) { result in
			switch result {
				case .success(let detail):
					// NOTE: ここtrueにするか怪しい
					self.todo.status!.finished = true
					self.todo.status!.detail = detail
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
