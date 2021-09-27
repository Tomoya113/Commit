//
//  SheetDataResponse.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

struct SheetDataResponse: Decodable {
	var sheets: [Sheet]
	
	struct Sheet: Decodable {
		var proterties: Properties
		struct Properties: Decodable {
			var sheetId: Int
			var title: String
		}
	}
}
