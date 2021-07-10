//
//  GoogleAPIClient.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

struct DriveConfig {
	let host: URL = URL(string: "https://sheets.googleapis.com")!
	let fixedPath: String = "/v4/spreadsheets"
}

struct SpreadSheetConfig {
	let host: URL = URL(string: "https://www.googleapis.com")!
	let fixedPath: String = "/drive/v3"
}

enum GoogleAPIRequestType {
	case spreadSheet
	case drive
}

class GoogleAPIClient: GoogleAPIClientProtocol {
	
	static let shared = GoogleAPIClient()
	let drive = DriveConfig()
	let spreadSheet = SpreadSheetConfig()
	let urlSession: URLSession
	var task: URLSessionTask?
	init(urlSession: URLSession = URLSession.shared) {
		self.urlSession = urlSession
	}
	
	let API_KEY = GoogleAPIInfo.API_KEY
	private var baseQueryItem: [URLQueryItem] {
		[URLQueryItem(name: "key", value: API_KEY)]
	}
	
	private func createBaseURLComponents(requestType: GoogleAPIRequestType, queries: [String: String], path: String) -> URLComponents {
		var fixedPath = ""
		let url: URL = {
			switch requestType {
				case .spreadSheet:
					// NOTE: ここではないぜったいに
					fixedPath = spreadSheet.fixedPath
					return spreadSheet.host
				case .drive:
					fixedPath = drive.fixedPath
					return drive.host
			}
		}()
		
		let queryItems: [URLQueryItem] =  queries.map { query in
			URLQueryItem(name: query.key, value: query.value)
		}
		
		var components: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.percentEncodedPath = fixedPath + path
		components.percentEncodedQueryItems = queryItems + baseQueryItem
		
		return components
	}
	
	private func createBaseURLRequest(httpMethod: HTTPMethod, _ components: URLComponents) -> URLRequest {
		
		var request = URLRequest(url: components.url!)
		request.httpMethod = httpMethod.rawValue
		request.addValue("Bearer \(API_KEY)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		return request
	}
	
	func fetchSpreadSheetFiles(contains sheetName: String?, completion: @escaping (Result<[SpreadSheetFile], Error>) -> ()) {
		let queries = DriveAPIManager.generateSpreadSheetSearchQueries(sheetName)
		let components = createBaseURLComponents(
			requestType: .drive,
			   queries: queries,
			   path: "/files"
		   )
		let request = createBaseURLRequest(httpMethod: .GET, components)
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			
			guard let data = data else {
				print("data not found")
				return
			}
			let decoder = JSONDecoder()
			
			do {
//				let jsonstr: String = String(data: data, encoding: .utf8)!
				let response = try decoder.decode(SpreadSheetFiles.self, from: data)
				DispatchQueue.main.async {
					completion(.success(response.files))
				}
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}
		}
		task?.resume()
	}
	
	func fetchSpreadSheetCells(_ query: FetchSpreadSheetCellsQuery, completion: @escaping (Result<[Cells], Error>) -> ()) {
		<#code#>
	}
	
	func fetchSpreadSheetInfo(id: String, completion: @escaping (Result<SpreadSheetInfo, Error>) -> ()) {
		<#code#>
	}
	
	func updateSpreadSheetCell(_ query: UpdateSpreadSheetCellQuery) {
		
	}
	
	func cancel() {
		task?.cancel()
	}
	
}
