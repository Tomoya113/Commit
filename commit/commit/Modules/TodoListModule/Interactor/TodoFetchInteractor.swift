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
