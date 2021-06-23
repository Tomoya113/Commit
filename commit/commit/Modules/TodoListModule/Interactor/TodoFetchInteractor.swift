//
//  TodoListSearchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoFetchInteractor: UseCase {
	let repository: Repository
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	func execute(_ parameters: String, completion: ((Result<[Todo], Never>) -> Void )?) {
		let todos = repository.findTodosById(parameters)
		completion?(.success(todos))
	}
	
	func cancel() {
		
	}
}
