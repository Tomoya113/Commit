//
//  GoogleAPIQueries.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

struct UpdateSpreadSheetCellQuery {
	let spreadsheetId: String
	let sheetName: String
	let row: String
	let column: String
	let text: String
}

struct FetchSpreadSheetCellsQuery {
	let sheetName: String
	let spreadSheetId: String
	let column: String
	let row: QueryRow
}

struct QueryRow {
	let start: String
	let end: String
}
