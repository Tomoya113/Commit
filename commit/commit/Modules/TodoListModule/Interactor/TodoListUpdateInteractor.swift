//
//  TodoListUpdateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoListUpdateInteractor: UseCase {
	let repository: Repository
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	func execute(_ parameters: Void, completion: ((Result<Void, Never>) -> Void )?) {
		
	}
	
	func cancel() {
		
	}
}
