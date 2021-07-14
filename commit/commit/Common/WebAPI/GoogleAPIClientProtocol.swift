//
//  GoogleAPIClientProtocol.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

protocol GoogleAPIClientProtocol {
	func fetchSpreadSheetFiles(contains sheetName: String?, completion: @escaping (Result<[SpreadSheetFile], Error>) -> Void)
	func fetchSpreadSheetCells(_ query: FetchSheetCellsQuery, completion: @escaping (Result<[String], Error>) -> Void)
	func fetchSpreadSheetInfo(id: String, completion: @escaping (Result<[Sheet], Error>) -> Void)
	func updateSpreadSheetCell(_ query: UpdateSpreadSheetCellQuery)
}
