//
//  TodoListSearchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class ListSearchInteractor: UseCase {
	let repository: Repository
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	func execute(_ parameters: Void, completion: ((Result<[ListRealm], Never>) -> Void )?) {
		let lists = repository.fetchLists()
		completion?(.success(lists))
	}
	
	func cancel() {
		
	}
}
