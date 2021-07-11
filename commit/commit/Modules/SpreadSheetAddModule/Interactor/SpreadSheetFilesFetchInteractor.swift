//
//  SpreadSheetFilesFetchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation

class SpreadSheetFilesFetchInteractor: UseCase {
	let repository: GoogleAPIClientProtocol
	
	init(repository: GoogleAPIClientProtocol = GoogleAPIClient.shared) {
		self.repository = repository
	}
	
	func execute(_ parameters: String, completion: ((Result<[SpreadSheetFile], Error>) -> Void )?) {
		repository.fetchSpreadSheetFiles(contains: parameters) { result in
			switch result {
				case .success(let files):
					completion?(.success(files))
				case .failure(let error):
					completion?(.failure(error))
			}
		}
	}
	
	func cancel() {
		
	}
}
