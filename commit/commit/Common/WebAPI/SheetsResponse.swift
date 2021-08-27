//
//  SheetsResponse.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import Foundation

struct SheetsFiles: Decodable {
	let kind: String
	let files: [SheetsFile]
}

struct SheetsFile: Decodable, Identifiable {
	var mimeType: String
	var id: String
	var kind: String
	var name: String
}

struct SheetsInfo: Decodable {
	var sheets: [Sheet]
}

struct Sheet: Decodable {
	var properties: SheetProperties
}

struct SheetProperties: Decodable {
	var sheetId: Int
	var title: String
}

struct Cells: Decodable {
	let values: [[String]]
}
