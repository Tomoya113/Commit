//
//  SpreadSheet.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import Foundation

struct SpreadSheetFiles: Decodable {
	let kind: String
	let files: [SpreadSheetFile]
}

struct SpreadSheetFile: Decodable, Identifiable {
	var mimeType: String
	var id: String
	var kind: String
	var name: String
}

struct SpreadSheetInfo: Decodable {
	var sheets: [Sheet]
}

struct Sheet: Decodable {
	var sheetProperties: SheetProperties
}

struct SheetProperties: Decodable {
	var sheetId: Int
	var title: String
}

struct Cells: Decodable {
	let values: [[String]]
}
