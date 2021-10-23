//
//  DriveAPI.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

final class DriveAPI {
	
	struct FetchSheets: GoogleAPIRequest {

		typealias Response = DriveResponse
		
		typealias APIError = DriveAPIError
		
		var fileName: String?

		var baseURL: URL {
			return URL(string: "https://sheets.googleapis.com")!
		}
		
		var path: String {
			return "/drive/v3/files/"
		}
		
		var method: HTTPMethod {
			return .get
		}
		
		var body: [String: Any]? {
			return nil
		}
		
		var queryItems: [URLQueryItem] {
			return [
				URLQueryItem(name: "supportsTeamDrives", value: "true"),
				URLQueryItem(name: "includeItemsFromAllDrives", value: "true"),
				URLQueryItem(name: "orderBy", value: "viewedByMeTime%20desc"),
				URLQueryItem(name: "q", value: query)
			]
		}
		
		var query: String {
			if let fileName = fileName {
				return "(mimeType='application/vnd.google-apps.spreadsheet' and name contains '\(fileName)')"
			} else {
				return "(mimeType='application/vnd.google-apps.spreadsheet')"
			}
		}
		
	}
}
