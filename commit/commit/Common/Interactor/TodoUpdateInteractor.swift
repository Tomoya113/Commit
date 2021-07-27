//
//  TodoListUpdateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoUpdateInteractor: UseCase {
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
		todoRepository.updateTodoStatusById(parameters.id)
		if parameters.todoType == "googleSheets" {
			print("googleSheets")
			sheetRepository.updateSheetTodo(parameters)
		}
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
}
