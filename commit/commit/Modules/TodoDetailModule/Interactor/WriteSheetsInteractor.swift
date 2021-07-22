//
//  WriteSheetsInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/21.
//

import Foundation

class WriteSheetsInteractor: UseCase {
	let todoRepository: TodoRepositoryProtocol
	let sheetRepository: SheetsRepositoryProtocol
	
	init(
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared,
		sheetRepository: SheetsRepositoryProtocol = SheetsRepository.shared
	) {
		self.todoRepository = todoRepository
		self.sheetRepository = sheetRepository
	}
	
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void )?) {
		if parameters.todoType != "googleSheets" {
			print("This is not sheet Todo")
			return
		}
		sheetRepository.updateSheetTodo(parameters)
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
}
