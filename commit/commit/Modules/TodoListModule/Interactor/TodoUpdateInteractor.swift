//
//  TodoListUpdateInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

class TodoUpdateInteractor: UseCase {
	let repository: Repository
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	func execute(_ parameters: String, completion: ((Result<Void, Never>) -> Void )?) {
		
	}
	
	func cancel() {
		
	}
}
