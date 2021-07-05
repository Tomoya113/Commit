//
//  TodoCreateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/04.
//

import Foundation

class TodoCreateInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol) {
		self.repository = repository
	}
	
	func execute(_ parameters: AddTodoQuery, completion: ((Result<Void, Never>) -> Void )?) {
		repository.createNewTodo(query: parameters) { _ in
			completion?(.success(()))
		}
	}
	
	func cancel() {
		
	}
}
