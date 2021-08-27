//
//  WriteSheetsInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/21.
//

import Foundation

class WriteSheetsInteractor: UseCase {
	let sheetsTodoAttributeRepository = RealmRepository<SheetsTodoAttribute>()
	let sheetPresetRepository = RealmRepository<Preset>()
	
	func execute(_ parameters: Todo, completion: ((Result<Void, Never>) -> Void )?) {
		if parameters.todoType != "googleSheets" {
			print("This is not sheet Todo")
			return
		}
		updateSheetTodo(parameters)
		completion?(.success(()))
	}
	
	func updateSheetTodo(_ todo: Todo) {
		// NOTE: もうちょっと上手く書けないかな
		var attribute: SheetsTodoAttribute?
		let predicate = NSPredicate(format: "todoId == %@", argumentArray: [todo.id])
		sheetsTodoAttributeRepository.find(predicate: predicate) { result in
			switch result {
				case .success(let attributes):
					guard let foundAttribute = attributes.first else {
						fatalError("sheetAttribute not found")
					}
					attribute = foundAttribute
				default:
					fatalError("sheetAttribute not found")
			}
		}
		
		guard let validAttribute = attribute else {
			print("attribute not found")
			return
		}
		
		let preset: Preset? = sheetPresetRepository.findByPrimaryKey(validAttribute.presetId)

		guard let validPreset = preset else {
			print("preset not found")
			return
		}
		
		let doneOrNot = todo.status!.finished ? "DONE" : ""
		let text = todo.status!.detail != "" ? todo.status!.detail : doneOrNot
		let query = UpdateSheetsCellQuery(
			sheetsId: validPreset.sheetsId,
			tabName: validPreset.tabName,
			targetRow: validPreset.targetRow,
			targetColumn: validAttribute.column,
			text: text
		)
		
		GoogleAPIClient.shared.updateSheetsCell(query)
	}
		
}
