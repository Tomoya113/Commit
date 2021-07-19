//
//  SampleTodoListRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation
import RealmSwift

class MockTodoRepository: TodoRepositoryProtocol {
	
	func createNewTodo(query: AddTodoQuery, completion: ((Result<Void, Never>) -> Void)?) {
		print("updated")
		completion?(.success(()))
	}
	
	func fetchLists(completion: ((Result<[ListRealm], Never>) -> Void)?) {
		completion?(.success(ListMock.lists))
	}
	
	func updateTodoStatusById(_ id: String) {
		print("updated")
	}
	
	func updateTodo(_ todo: Todo) {
		print("updateTodo")
	}
	
	func fetchCurrentList() -> ListRealm? {
		return ListMock.list1
	}
	
	func createNewSection(section: SectionRealm) {
		print("createNewSection")
	}
	
	func delete(_ object: Object) {
		print("delete")
	}
		
}
