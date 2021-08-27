//
//  ListSearchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/23.
//

import Foundation

class ListFetchInteractor: UseCase {
	let listRepository = RealmRepository<ListRealm>()
	
	func execute(_ parameters: Void, completion: ((Result<[ListRealm], Never>) -> Void )?) {
		let lists = listRepository.findAll()
		completion?(.success(lists))
	}
	
	func cancel() {
		
	}
}
