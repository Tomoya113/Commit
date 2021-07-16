//
//  GoogleAPIClient.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

struct DriveConfig {
	let host: URL = URL(string: "https://www.googleapis.com")!
	let fixedPath: String = "/drive/v3"
}

struct SpreadSheetConfig {
	let host: URL = URL(string: "https://sheets.googleapis.com")!
	let fixedPath: String = "/v4/spreadsheets"
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
		print(queries, baseQueryItem)
		
		let queryItems: [URLQueryItem] =  queries.map { query in
			URLQueryItem(name: query.key, value: query.value)
		}
		
		var components: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		let fullpath: String = fixedPath + path
		components.percentEncodedPath = fullpath.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
		components.percentEncodedQueryItems = queryItems + baseQueryItem
		
		return components
	}
	
	private func createBaseURLRequest(httpMethod: HTTPMethod, _ components: URLComponents) -> URLRequest {
		
		var request = URLRequest(url: components.url!)
		request.httpMethod = httpMethod.rawValue
		request.addValue("Bearer \(GoogleOAuthManager.shared.token)", forHTTPHeaderField: "Authorization")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		return request
	}
	
	func fetchSpreadSheetFiles(contains sheetName: String?, completion: @escaping (Result<[SpreadSheetFile], Error>) -> Void) {
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
				let response = try decoder.decode(SpreadSheetFiles.self, from: data)
				completion(.success(response.files))
			} catch {
				print(error)
				completion(.failure(error))
			}
		}
		task?.resume()
	}
	
	func fetchSpreadSheetCells(_ query: FetchSheetCellsQuery, completion: @escaping (Result<[String], Error>) -> Void) {
		let startRange = "\(query.column.start)\(query.row)"
		let endRange = "\(query.column.end)\(query.row)"
		let path = "/\(query.spreadSheetId)/values/\(query.sheetName)!\(startRange):\(endRange)"
		let components = createBaseURLComponents(
			requestType: .spreadSheet,
			queries: [:],
			path: path
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
				let response = try decoder.decode(Cells.self, from: data)
				DispatchQueue.main.async {
					completion(.success(response.values[0]))
				}
			} catch {
				print(error)
				let jsonstr: String = String(data: data, encoding: .utf8)!
				print("jsonstr", jsonstr)
				completion(.failure(error))
			}
		}
		task?.resume()
		
	}
	
	func fetchSpreadSheetInfo(id: String, completion: @escaping (Result<[Sheet], Error>) -> Void) {
		let components = createBaseURLComponents(
			requestType: .spreadSheet,
			queries: [:],
			path: "/\(id)"
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
			let jsonstr: String = String(data: data, encoding: .utf8)!
			print(jsonstr)
			do {
				let response = try decoder.decode(SpreadSheetInfo.self, from: data)
				completion(.success(response.sheets))
			} catch {
				print(error)
				completion(.failure(error))
			}
		}
		task?.resume()
	}
	
	func updateSpreadSheetCell(_ query: UpdateSpreadSheetCellQuery) {
		let queries: [String: String] = SheetsAPIManager.generateSpreadSheetUpdateQueries()
		let path: String =  "/\(query.spreadsheetId)/values/\(query.tabName)!\(query.targetColumn)\(query.targetRow)"
		let components = createBaseURLComponents(
			requestType: .spreadSheet,
			queries: queries,
			path: path
		)
		var request = createBaseURLRequest(httpMethod: .PUT, components)
		// 別のところにかけたら良さそう
		let body: [String: Any] = ["values": [[query.text]]]
		request.httpBody = try? JSONSerialization.data(withJSONObject: body)
		task = URLSession.shared.dataTask(with: request) { _, _, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
		}
		task?.resume()
	}
	
	func cancel() {
		task?.cancel()
	}
	
}
