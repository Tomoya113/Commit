//
//  GoogleAPIInfo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/06.
//

import Foundation

struct GoogleAPIInfo {
	static let CLIENT_ID: String = "289855344058-rdkvemkkcvimr072l29mvgh3hefiv1tj.apps.googleusercontent.com"
	static let driveFull: String = "https://www.googleapis.com/auth/drive"
	static let sheetsFull: String = "https://www.googleapis.com/auth/spreadsheets"
	static let scopes: [String] = [driveFull, sheetsFull]
}
