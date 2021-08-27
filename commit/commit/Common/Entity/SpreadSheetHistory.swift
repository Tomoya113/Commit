//
//  SpreadSheetHistory.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class SpreadSheetHistory: Object, ObjectKeyIdentifiable {
	@objc dynamic var sheetId: String = ""
	@objc dynamic var title: String = ""
	
	convenience init(sheetId: String, title: String) {
		self.init()
		self.sheetId = sheetId
		self.title = title
	}
	
}
