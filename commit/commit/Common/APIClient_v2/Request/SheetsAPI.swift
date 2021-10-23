//
//  SheetsAPI.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

final class SheetsAPI {
	struct FetchSheetCell: GoogleAPIRequest {

		let spreadsheetId: String
		let retreavingRange: String
		
		typealias Response = SheetCellsResponse
		typealias APIError = SheetsAPIError
		
		var baseURL: URL {
			return URL(string: "https://sheets.googleapis.com")!
		}
		
		var path: String {
			return "/v4/spreadsheets/\(spreadsheetId)/values/\(retreavingRange)"
		}
		
		var body: [String: Any]? {
			return nil
		}
		
		var queryItems: [URLQueryItem] {
			return [URLQueryItem(name: "key", value: GoogleAPIInfo.API_KEY)]
		}

		var method: HTTPMethod {
			return .get
		}
		
		init(sheetId: String, retreavingRange: String) {
			self.spreadsheetId = sheetId
			self.retreavingRange = retreavingRange
		}
	}
	
	struct FetchSpreadSheetProperties: GoogleAPIRequest {
		
		let spreadsheetId: String
		
		typealias Response = SheetsPropertiesResponse

		typealias APIError = SheetsAPIError

		var baseURL: URL {
			return URL(string: "https://sheets.googleapis.com")!
		}

		var path: String {
			return "/v4/spreadsheets/\(spreadsheetId)"
		}

		var body: [String: Any]? {
			return nil
		}

		var queryItems: [URLQueryItem] {
			return [URLQueryItem(name: "key", value: GoogleAPIInfo.API_KEY)]
		}

		var method: HTTPMethod {
			return .get
		}
	}

	struct UpdateCell: GoogleAPIRequest {

		let spreadsheetId: String
		let targetRange: String
		let value: String
		
		typealias Response = SheetUpdateResponse
		typealias APIError = SheetsAPIError
		
		var baseURL: URL {
			return URL(string: "https://sheets.googleapis.com")!
		}
		
		var path: String {
			return "/v4/spreadsheets/\(spreadsheetId)/values/\(targetRange)"
		}
		
		var method: HTTPMethod {
			return .put
		}
		
		var body: [String: Any]? {
			return ["values": [
				value
				]
			]
		}
		
		var queryItems: [URLQueryItem] {
			return [
				URLQueryItem(name: "key", value: GoogleAPIInfo.API_KEY),
				URLQueryItem(name: "valueInputOption", value: "RAW")
			]
		}
		
		init(sheetId: String, targetRange: String, value: String) {
			self.spreadsheetId = sheetId
			self.targetRange = targetRange
			self.value = value
		}
	}
	
}
