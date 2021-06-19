//
//  SpreadSheetHistory.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class SpreadSheetHistory: Object, ObjectKeyIdentifiable {
	@objc dynamic var spreadSheetId: String = ""
	@objc dynamic var title: String = ""
	
	convenience init(spreadSheetId: String, title: String) {
		self.init()
		self.spreadSheetId = spreadSheetId
		self.title = title
	}
	
}
