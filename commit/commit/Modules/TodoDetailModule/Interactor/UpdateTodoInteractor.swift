//
//  UpdateTodoInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation

class UpdateTodoInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol) {
		self.repository = repository
	}
	
	// Todo: Neverではないやろ絶対に
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void)?) {
		repository.updateTodo(parameters)
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
}
