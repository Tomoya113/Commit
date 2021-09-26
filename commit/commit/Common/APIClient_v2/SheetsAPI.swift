//
//  SheetsAPI.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

final class SheetsAPI {
	struct FetchSheetCell: GoogleAPIRequest {

		let sheetId: String
		let retreavingRange: String
		
		typealias Response = SheetCellsResponse
		typealias APIError = SheetsAPIError
		
		var baseURL: URL {
			return URL(string: "https://sheets.googleapis.com")!
		}
		
		var path: String {
			return "/v4/spreadsheets/\(sheetId)/values/\(retreavingRange)"
		}
		
		var body: [String: Any]? {
			return nil
		}
		
		public var queryItems: [URLQueryItem] {
			return [URLQueryItem(name: "key", value: GoogleAPIInfo.API_KEY)]
		}

		var method: HTTPMethod {
			return .get
		}
		
		init(sheetId: String, retreavingRange: String) {
			self.sheetId = sheetId
			self.retreavingRange = retreavingRange
		}
		
	}
}
