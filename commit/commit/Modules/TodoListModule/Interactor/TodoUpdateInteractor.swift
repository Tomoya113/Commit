//
//  TodoListUpdateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoUpdateInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol = TodoListRepository()) {
		self.repository = repository
	}
	
	func execute(_ parameters: String, completion: ((Result<Void, Never>) -> Void )?) {
		repository.updateTodoStatusById(parameters)
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
}
