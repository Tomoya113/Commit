//
//  SheetRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation
import RealmSwift

class SheetRepository: SheetRepositoryProtocol {
		
	let realm = try! Realm()
	static let shared = SheetRepository()
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
		guard let sheetAttribute = sheetAttribute else {
			fatalError("sheetAttribute not found")
		}
		
		let preset = realm.object(ofType: Preset.self, forPrimaryKey: sheetAttribute.presetId)
		guard let preset = preset else {
			fatalError("preset not found")
		}
		
		let query = UpdateSpreadSheetCellQuery(
			spreadsheetId: preset.spreadSheetId,
			tabName: preset.tabName,
			targetRow: preset.targetRow,
			targetColumn: sheetAttribute.column,
			// 後で変えよう
			text: todo.status!.finished ? "DONE" : ""
		)
		
		googleAPiClient.updateSpreadSheetCell(query)
	}
	
}
