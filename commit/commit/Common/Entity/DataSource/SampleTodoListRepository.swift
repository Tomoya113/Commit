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
	func findTodosById(_ id: String, completion: ((Result<[Todo], Never>) -> Void)?) {
		completion?(.success(TodoMock.todosA))
	}
	
	func fetchLists(completion: ((Result<[ListRealm], Never>) -> Void)?) {
		completion?(.success(ListMock.lists))
	}
	
	func updateTodoStatusById(_ id: String) {
		print("updated")
	}
}
