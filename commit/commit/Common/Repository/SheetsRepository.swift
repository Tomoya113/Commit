//
//  SheetRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation
import RealmSwift

class SheetsRepository: SheetsRepositoryProtocol {
		
	let realm = try! Realm()
	static let shared = SheetsRepository()
	let googleAPiClient = GoogleAPIClient.shared
	
	func createPreset(_ query: Preset) {
		do {
			try realm.write {
				realm.add(query)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func createSheetTodoAttribute(_ query: SheetTodoQuery) {
		let sheetTodo: SpreadSheetTodoAttribute = SpreadSheetTodoAttribute(
			todoId: query.todoId,
			presetId: query.presetId,
			column: query.column
		)
		
		do {
			try realm.write {
				realm.add(sheetTodo)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func updateSheetTodo(_ todo: Todo) {
		let sheetAttribute = realm.objects(SpreadSheetTodoAttribute.self).filter("todoId == %@", todo.id).first
		guard let attribute = sheetAttribute else {
			fatalError("sheetAttribute not found")
		}
		
		let preset = realm.object(ofType: Preset.self, forPrimaryKey: attribute.presetId)
		guard let validPreset = preset else {
			fatalError("preset not found")
		}
		
		let doneOrNot = todo.status!.finished ? "DONE" : ""
		let text = todo.status!.detail != "" ? todo.status!.detail : doneOrNot
		let query = UpdateSpreadSheetCellQuery(
			spreadsheetId: validPreset.spreadSheetId,
			tabName: validPreset.tabName,
			targetRow: validPreset.targetRow,
			targetColumn: attribute.column,
			text: text
		)
		
		googleAPiClient.updateSpreadSheetCell(query)
	}
	
	func getSheetsAttribute(_ todo: Todo) -> SpreadSheetTodoAttribute {
		let sheetAttribute = realm.objects(SpreadSheetTodoAttribute.self).filter("todoId == %@", todo.id).first
		
		guard let attribute = sheetAttribute else {
			fatalError("sheetAttribute not found")
		}
		return attribute
	}
	
	func getSheetsPresetById(_ id: String) -> Preset {
		let preset = realm.object(ofType: Preset.self, forPrimaryKey: id)
		guard let validPreset = preset else {
			fatalError("preset not found")
		}
		return validPreset
	}
}
