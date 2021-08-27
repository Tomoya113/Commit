//
//  GoogleAPIClient.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

class GoogleAPIClient: GoogleAPIClientProtocol {
	
	static let shared = GoogleAPIClient()
	let urlSession: URLSession
	var task: URLSessionTask?
	init(urlSession: URLSession = URLSession.shared) {
		self.urlSession = urlSession
	}
	
	func fetchSheetsFiles(contains sheetName: String?, completion: @escaping (Result<[SpreadSheetFile], Error>) -> Void) {
		let baseRequest = GoogleAPIRequest.drive
		
		let queries = DriveAPIManager.generateSpreadSheetSearchQueries(sheetName)
		
		let request = baseRequest.createRequest(
			queries: queries,
			additonalPath: "/files",
			httpMethod: .GET,
			httpBody: nil
		)
		
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			
			guard let newData = data else {
				print("data not found")
				return
			}
			let decoder = JSONDecoder()
			
			do {
				let response = try decoder.decode(SpreadSheetFiles.self, from: newData)
				completion(.success(response.files))
			} catch {
				print(error)
				completion(.failure(error))
			}
		}
		task?.resume()
	}
	
	func fetchSpreadSheetCell(_ query: FetchSheetsCellQuery, completion: @escaping (Result<String, Error>) -> Void) {
		let path = "/\(query.spreadSheetId)/values/\(query.sheetName)!\(query.column)\(query.row)"
		
		// NOTE: 絶対命名ゴミなんだよな
		let baseRequest = GoogleAPIRequest.sheets
		
		let request = baseRequest.createRequest(
			queries: [:],
			additonalPath: path,
			httpMethod: .GET,
			httpBody: nil)
		
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			
			guard let newData = data else {
				print("data not found")
				return
			}
			let decoder = JSONDecoder()
			
			do {
				let response = try decoder.decode(Cells.self, from: newData)
				// NOTE: ここの書き方嫌い
				if let array = response.values.first {
					if let value = array.first {
						DispatchQueue.main.async {
							completion(.success(value))
						}
					} else {
						DispatchQueue.main.async {
							completion(.success(""))
						}
					}
				} else {
					DispatchQueue.main.async {
						completion(.success(""))
					}
				}
				
			} catch {
				print(error)
				let jsonstr: String = String(data: newData, encoding: .utf8)!
				print("jsonstr", jsonstr)
				completion(.failure(error))
			}
		}
		task?.resume()
	}
	
	func fetchSheetsCells(_ query: FetchSheetCellsQuery, completion: @escaping (Result<[String], Error>) -> Void) {
		let startRange = "\(query.column.start)\(query.row)"
		let endRange = "\(query.column.end)\(query.row)"
		let path = "/\(query.spreadSheetId)/values/\(query.sheetName)!\(startRange):\(endRange)"
		
		let baseRequest = GoogleAPIRequest.sheets
		
		let request = baseRequest.createRequest(
			queries: [:],
			additonalPath: path,
			httpMethod: .GET,
			httpBody: nil
		)
		
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			
			guard let newData = data else {
				print("data not found")
				return
			}
			let decoder = JSONDecoder()
			
			do {
				let response = try decoder.decode(Cells.self, from: newData)
				DispatchQueue.main.async {
					completion(.success(response.values[0]))
				}
			} catch {
				print(error)
				let jsonstr: String = String(data: newData, encoding: .utf8)!
				print("jsonstr", jsonstr)
				completion(.failure(error))
			}
		}
		task?.resume()
		
	}
	
	func fetchSheetsInfo(id: String, completion: @escaping (Result<[Sheet], Error>) -> Void) {
		
		let baseRequest = GoogleAPIRequest.sheets
		
		let request = baseRequest.createRequest(
			queries: [:],
			additonalPath: "/\(id)",
			httpMethod: .GET,
			httpBody: nil
		)
		
		task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("クライアントエラー: \(error.localizedDescription) \n")
				return
			}
			
			guard let newData = data else {
				print("data not found")
				return
			}
			let decoder = JSONDecoder()
			let jsonstr: String = String(data: newData, encoding: .utf8)!
			print(jsonstr)
			do {
				let response = try decoder.decode(SpreadSheetInfo.self, from: newData)
				completion(.success(response.sheets))
			} catch {
				print(error)
				completion(.failure(error))
			}
		}
		task?.resume()
	}
	
	func updateSheetsCell(_ query: UpdateSpreadSheetCellQuery) {
		let queries: [String: String] = SheetsAPIManager.generateSpreadSheetUpdateQueries()
		let path: String =  "/\(query.spreadsheetId)/values/\(query.tabName)!\(query.targetColumn)\(query.targetRow)"
		
		let baseRequest = GoogleAPIRequest.sheets
		// 別のところにかけたら良さそう
		let body: [String: Any] = ["values": [[query.text]]]
		
		let request = baseRequest.createRequest(
			queries: queries,
			additonalPath: path,
			httpMethod: .PUT,
			httpBody: body
		)
		
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
