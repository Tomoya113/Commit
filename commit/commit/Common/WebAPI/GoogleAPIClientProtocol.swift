//
//  GoogleAPIClientProtocol.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

protocol GoogleAPIClientProtocol {
	func fetchSheetsFiles(contains sheetName: String?, completion: @escaping (Result<[SheetsFile], Error>) -> Void)
	func fetchSheetsCells(_ query: FetchSheetCellsQuery, completion: @escaping (Result<[String], Error>) -> Void)
	func fetchSheetsInfo(id: String, completion: @escaping (Result<[Sheet], Error>) -> Void)
	func updateSheetsCell(_ query: UpdateSheetsCellQuery)
}
