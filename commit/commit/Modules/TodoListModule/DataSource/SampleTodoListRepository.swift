//
//  SampleTodoListRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class SampleTodoRepository: Repository {
//	let realm = try! Realm()
	
	func findTodosById(_ id: String) -> [Todo] {
		return TodoMock.todosA
	}
	
	func fetchLists() -> [ListRealm] {
		return ListMock.lists
	}
	
	func updateTodoStatusById(_ id: String) {
		for todo in TodoMock.todosA where todo.id == id {
			todo.status?.finished.toggle()
		}
	}
}
