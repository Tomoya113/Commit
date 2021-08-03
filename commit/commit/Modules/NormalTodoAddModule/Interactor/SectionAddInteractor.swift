//
//  SectionAddInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/02.
//

import Foundation

class SectionAddInteractor: UseCase {
	func execute(_ parameters: SectionRealm, completion: ((Result<Void, Never>) -> Void)?) {
		let listRepository = RealmRepository<ListRealm>()
		let list = listRepository.findAll().first
		if let list = list {
			listRepository.transaction {
				list.sections.append(parameters)
			}
			completion?(.success(()))
		}
	}
	
	func cancel() {
	}
}
