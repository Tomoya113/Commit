//
//  TodoListSearchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoFetchInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol) {
		self.repository = repository
	}
	
	// FIXME: Neverではないやろ絶対に
	func execute(_ parameters: String, completion: ((Result<[Todo], Never>) -> Void )?) {
		repository.findTodosById(parameters) { result in
			switch result {
				case .success(let todos):
					completion?(.success(todos))
			}
		}
	}
	
	func cancel() {
		
	}
}
