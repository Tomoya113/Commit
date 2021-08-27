//
//  SpreadSheetCellsFetchInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/11.
//

import Foundation

class CellsFetchInteractor: UseCase {
	let repository: GoogleAPIClientProtocol
	
	init(repository: GoogleAPIClientProtocol = GoogleAPIClient.shared) {
		self.repository = repository
	}
	
	func execute(_ parameters: FetchSheetCellsQuery, completion: ((Result<[String], Error>) -> Void )?) {
		repository.fetchSpreadSheetCells(parameters) { result in
			switch result {
				case .success(let cells):
					completion?(.success(cells))
				case .failure(let error):
					completion?(.failure(error))
			}
		}
	}
}
