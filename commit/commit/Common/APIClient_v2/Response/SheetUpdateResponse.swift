//
//  SheetUpdateResponse.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/28.
//

import Foundation

struct SheetUpdateResponse: Decodable {
	var spreadsheetId: String
	var updateRange: String
	var updateRows: Int
	var updateColumns: Int
	var updateCells: Int
}
