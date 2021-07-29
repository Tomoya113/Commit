//
//  DeleteSectionInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/29.
//

import Foundation

class DeleteSectionInteractor: UseCase {
	let repository: TodoRepositoryProtocol
	
	init(repository: TodoRepositoryProtocol = TodoRepository.shared) {
		self.repository = repository
	}
	
	func execute(_ parameters: SectionRealm, completion: ((Result<Void, Never>) -> Void )?) {
		let sectionRepository = RealmRepository<SectionRealm>()
		sectionRepository.delete(entities: [parameters])
		completion?(.success(()))
	}
	
	func cancel() {
		
	}
}
