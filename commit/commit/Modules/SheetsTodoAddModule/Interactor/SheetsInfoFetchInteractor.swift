//
//  SheetsInfoFetchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/11.
//

import Foundation

class SheetsInfoFetchInteractor: UseCase {
	let repository: GoogleAPIClientProtocol
	
	init(repository: GoogleAPIClientProtocol = GoogleAPIClient.shared) {
		self.repository = repository
	}
	
	func execute(_ parameters: String, completion: ((Result<[Sheet], Error>) -> Void )?) {
		repository.fetchSheetsInfo(id: parameters) { result in
			switch result {
				case .success(let sheets):
					completion?(.success(sheets))
				case .failure(let error):
					completion?(.failure(error))
			}
		}
	}
}
