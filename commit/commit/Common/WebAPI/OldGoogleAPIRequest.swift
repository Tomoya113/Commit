//
//  OldGoogleAPIRequest.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/20.
//

import Foundation

enum OldGoogleAPIRequest {
	case sheets
	case drive
	
	var host: URL {
		switch self {
			case .drive:
				return URL(string: "https://www.googleapis.com")!
			case .sheets:
				return URL(string: "https://sheets.googleapis.com")!
		}
	}
	
	var path: String {
		switch self {
			case .drive:
				return "/drive/v3"
			case .sheets:
				return "/v4/spreadsheets"
		}
	}
	
	// NOTE: 命名もうちょっと考えたい
	func createRequest(
		queries: [String: String],
		additonalPath: String,
		httpMethod: HTTPMethod,
		// NOTE: requestBodyは外部から差し込んでも良さそうだと思いました
		httpBody: [String: Any]?
	) -> URLRequest {
		let components = createURLComponents(
			queries: queries,
			additonalPath: additonalPath
		)
		let request = createURLRequest(
			httpMethod: httpMethod,
			httpBody: httpBody,
			components
		)
		return request
	}
	
	private func createURLComponents(
		queries: [String: String],
		additonalPath: String
	) -> URLComponents {
		
		let queryItems: [URLQueryItem] =  queries.map { query in
			URLQueryItem(name: query.key, value: query.value)
		}
		
		var components: URLComponents = URLComponents(url: host, resolvingAgainstBaseURL: false)!
		let fullpath: String = path + additonalPath
		components.percentEncodedPath = fullpath.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
		components.percentEncodedQueryItems = queryItems + [URLQueryItem(name: "key", value: GoogleAPIInfo.API_KEY)]
		
		return components
	}
	
	private func createURLRequest(
		httpMethod: HTTPMethod,
		httpBody: [String: Any]?,
		_ components: URLComponents
	) -> URLRequest {
		var request = URLRequest(url: components.url!)
		request.httpMethod = httpMethod.rawValue
		// NOTE: ここ疎結合にしたい
		request.addValue("Bearer \(GoogleOAuthManager.shared.token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		if let body = httpBody {
			// ここでJSON化して良い？
			request.httpBody = try? JSONSerialization.data(withJSONObject: body)
		}
		
		return request
	}
}
