//
//  SheetsAPIManager.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/10.
//

import Foundation

struct SheetsAPIManager {
	static func generateSpreadSheetUpdateQueries() -> [String: String] {
		return [
			"valueInputOption": "RAW",
		]
	}
}
