//
//  FetchSheetsCellInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/20.
//

import Foundation

class FetchSheetsCellInteractor: UseCase {
	let todoRepository: TodoRepositoryProtocol
	let sheetsTodoAttributeRepository = RealmRepository<SheetsTodoAttribute>()
	let sheetPresetRepository = RealmRepository<Preset>()
	
	init(
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared
	) {
		self.todoRepository = todoRepository
	}
	
	func execute(_ parameters: Todo, completion: ((Result<String, Error>) -> Void )?) {
		// ちゃんとエラーハンドリングしようね
		var sheetsTodoAttribute: SheetsTodoAttribute?
		let predicate = NSPredicate(format: "todoId == %@", argumentArray: [parameters.id])
		sheetsTodoAttributeRepository.find(predicate: predicate) { result in
			switch result {
				case .success(let attributes):
					guard let foundAttribute = attributes.first else {
						fatalError("sheetAttribute not found")
					}
					sheetsTodoAttribute = foundAttribute
				default:
					fatalError("sheetAttribute not found")
			}
		}
		
		guard let validAttribute = sheetsTodoAttribute else {
			print("attribute not found")
			return
		}
		
		let preset: Preset? = sheetPresetRepository.findByPrimaryKey(validAttribute.presetId)

		guard let validPreset = preset else {
			print("preset not found")
			return
		}
		
		let fetchSheetsCellQuery: FetchSheetsCellQuery = FetchSheetsCellQuery(
			sheetName: validPreset.tabName,
			spreadSheetId: validPreset.spreadSheetId,
			column: validAttribute.column,
			row: validPreset.targetRow
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
