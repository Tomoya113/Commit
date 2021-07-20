//
//  DeleteTodoInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/18.
//

import Foundation

class FetchSheetsCellInteractor: UseCase {
	let todoRepository: TodoRepositoryProtocol
	let sheetsRepository: SheetsRepositoryProtocol
	
	init(
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared,
		sheetsRepository: SheetsRepositoryProtocol = SheetsRepository.shared
	) {
		self.todoRepository = todoRepository
		self.sheetsRepository = sheetsRepository
	}
	
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void )?) {
		todoRepository.
		todoRepository.delete(parameters)
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
	
}
