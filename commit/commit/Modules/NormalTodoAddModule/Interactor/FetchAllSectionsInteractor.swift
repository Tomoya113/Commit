//
//  FetchAllSectionsInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/03.
//

import Foundation

class FetchAllSectionsInteractor: UseCase {
	func execute(_ parameters: String, completion: ((Result<[SectionRealm], Never>) -> Void)?) {
		let listRepository = RealmRepository<ListRealm>()
		let list = listRepository.findAll().first
		if let list = list {
			let sections = list.sections
			completion?(.success(Array(sections)))
		}
	}
	
	func cancel() {
	}
}
