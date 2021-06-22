//
//  SampleTodoListRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation
import RealmSwift

class SampleTodoRepository: Repository {
	let realm = try! Realm()
	
	func findTodosById(_ id: String) -> [Todo] {
		return TodoMock.todosA
	}
	
	func fetchLists() -> [ListRealm] {
		return ListMock.lists
	}
	
	func updateNormalTodoStatusById(_ id: String) {
		
	}
}
