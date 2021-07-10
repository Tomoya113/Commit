//
//  DriveAPIManager.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/10.
//

import Foundation

struct DriveAPIManager {
	static func generateSpreadSheetSearchQueries(_ sheetName: String?) -> [String: String] {
		var baseQuery = [
			"supportsTeamDrives": "true",
			"includeItemsFromAllDrives": "true"
		]
		if let sheetName = sheetName {
			baseQuery["q"] = "(mimeType='application/vnd.google-apps.spreadsheet' and name contains '\(sheetName)')"
		} else {
			baseQuery["q"] = "mimeType='application/vnd.google-apps.spreadsheet'"
		}
		return baseQuery
	}
}
