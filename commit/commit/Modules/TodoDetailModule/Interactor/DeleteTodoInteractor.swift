//
//  DeleteTodoInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/18.
//

import Foundation

class DeleteTodoInteractor: UseCase {
	let todoRepository: TodoRepositoryProtocol
	
	init(
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared
	) {
		self.todoRepository = todoRepository
	}
	
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void )?) {
		todoRepository.delete(parameters)
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
	
}
