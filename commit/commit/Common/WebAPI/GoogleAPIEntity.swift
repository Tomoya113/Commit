//
//  GoogleAPIEntity.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/20.
//
import Foundation

struct UpdateSheetsCellQuery {
	let sheetsId: String
	let tabName: String
	let targetRow: String
	let targetColumn: String
	let text: String
}

struct QueryColumn {
	let start: String
	let end: String
}

struct FetchSheetCellsQuery {
	let sheetName: String
	let sheetsId: String
	let column: QueryColumn
	let row: String
}

struct FetchSheetsCellQuery {
	let sheetName: String
	let sheetsId: String
	let column: String
	let row: String
}
