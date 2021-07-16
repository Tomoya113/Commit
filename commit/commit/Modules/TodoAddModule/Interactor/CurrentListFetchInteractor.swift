//
//  CurrentListFetchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation

class CurrentListFetchInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol = TodoRepository.shared) {
		self.repository = repository
	}
	
	// NOTE: Stringではないので変えたい
	func execute(_ parameters: String, completion: ((Result<ListRealm, Error>) -> Void )?) {
		let currentList = repository.fetchCurrentList()
		if let currentList = currentList {
			completion?(.success(currentList))
		} else {
			completion?(.failure(NSError(domain: "", code: 400, userInfo: nil)))
		}
	}
	
	func cancel() {
		
	}
}
