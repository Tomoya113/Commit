//
//  ListSearchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/23.
//

import Foundation

class ListFetchInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol) {
		self.repository = repository
	}
	
	func execute(_ parameters: Void, completion: ((Result<[ListRealm], Never>) -> Void )?) {
		repository.fetchLists { result in
			switch result {
				case .success(let lists):
					completion?(.success(lists))
			}
		}
	}
	
	func cancel() {
		
	}
}
