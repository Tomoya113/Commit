//
//  TodoCreateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/04.
//

import Foundation

class TodoCreateInteractor: UseCase {
	let sectionRepository = RealmRepository<SectionRealm>()
	let todoRepository = RealmRepository<Todo>()
	
	func execute(_ parameters: AddTodoQuery, completion: ((Result<Void, Never>) -> Void )?) {
		// NOTE: Neverじゃないだろ
		guard let section = sectionRepository.findByPrimaryKey(parameters.sectionId) else {
			fatalError("section not found")
		}
		sectionRepository.transaction {
			section.todos.append(parameters.todo)
		}
		completion?(.success(()))
	}
}
