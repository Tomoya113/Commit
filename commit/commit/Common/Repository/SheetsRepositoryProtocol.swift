//
//  SheetRepositoryProtocol.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation

protocol SheetsRepositoryProtocol {
	func createPreset(_ query: Preset)
	func createSheetTodoAttribute(_ query: SheetTodoQuery)
	func updateSheetTodo(_ todo: Todo)
	func getSheetsAttribute(_ todo: Todo) -> SpreadSheetTodoAttribute
}
