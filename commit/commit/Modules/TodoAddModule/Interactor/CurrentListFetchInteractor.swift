//
//  CurrentListFetchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation

class CurrentListFetchInteractor: UseCase {
	let listRepository = RealmRepository<ListRealm>()
	
	// NOTE: Stringではないので変えたい
	func execute(_ parameters: String, completion: ((Result<ListRealm, Error>) -> Void )?) {
		let lists = listRepository.findAll()
		if lists.isEmpty {
			completion?(.failure(NSError(domain: "", code: 400, userInfo: nil)))
		} else {
			completion?(.success(lists[0]))
		}
	}
	
}
