//
//  FetchSheetsCellInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/20.
//

import Foundation

class FetchSheetsCellInteractor: UseCase {
	let todoRepository: TodoRepositoryProtocol
	let sheetsRepository: SheetsRepositoryProtocol
	
	init(
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared,
		sheetsRepository: SheetsRepositoryProtocol = SheetsRepository.shared
	) {
		self.todoRepository = todoRepository
		self.sheetsRepository = sheetsRepository
	}
	
	func execute(_ parameters: Todo, completion: ((Result<String, Error>) -> Void )?) {
		// ちゃんとエラーハンドリングしようね
		let sheetsAttribute = sheetsRepository.getSheetsAttribute(parameters)
		let sheetsPreset = sheetsRepository.getSheetsPresetById(sheetsAttribute.presetId)
		let fetchSheetsCellQuery: FetchSheetsCellQuery = FetchSheetsCellQuery(
			sheetName: sheetsPreset.tabName,
			spreadSheetId: sheetsPreset.spreadSheetId,
			column: sheetsAttribute.column,
			row: sheetsPreset.targetRow
		)
		GoogleAPIClient.shared.fetchSpreadSheetCell(fetchSheetsCellQuery) { result in
			switch result {
				case .success(let cell):
					completion?(.success(cell))
				case .failure(let error):
					completion?(.failure(error))
			}
		}
	}
	
	func cancel() {
		
	}
	
}
