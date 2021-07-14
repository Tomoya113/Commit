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
	
	func createPreset(_ query: SheetPresetQuery) {
		// HELP: 実体を投げたほうが良いのか、クエリを投げるようにしたほうが良いのかわからん
		let sheetColumn = SheetColumn(start: query.column.start, end: query.column.end)
		let range = SheetRange(row: query.row, column: sheetColumn)
		let preset = Preset(
			spreadSheetId: query.spreadSheetId,
			tabName: query.tabName,
			title: query.title,
			range: range,
			targetRow: query.targetRow)
		do {
			try realm.write {
				realm.add(preset)
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
}
