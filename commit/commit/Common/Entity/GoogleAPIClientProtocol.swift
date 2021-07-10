//
//  GoogleAPIClientProtocol.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/09.
//

import Foundation

protocol GoogleAPIClientProtocol {
	func fetchSpreadSheetFiles(contains sheetName: String?, completion: @escaping (Result<[SpreadSheetFile], Error>) -> ())
	func fetchSpreadSheetCells(_ query: FetchSpreadSheetCellsQuery, completion: @escaping (Result<[Cells], Error>) -> ())
	func fetchSpreadSheetInfo(id: String, completion: @escaping (Result<SpreadSheetInfo, Error>) -> ())
	func updateSpreadSheetCell(_ query: UpdateSpreadSheetCellQuery) -> Void
}
