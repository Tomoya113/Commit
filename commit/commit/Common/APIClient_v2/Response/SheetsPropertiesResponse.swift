//
//  SpreadsheetPropertiesResponse.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

struct SheetsPropertiesResponse: Decodable {
	var sheets: [Sheet]
	
	struct Sheet: Decodable {
		var proterties: SheetProperties
		struct SheetProperties: Decodable {
			var sheetId: Int
			var title: String
		}
	}
}
