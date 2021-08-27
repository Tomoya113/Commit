//
//  SpreadSheetHistory.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class SpreadSheetHistory: Object, ObjectKeyIdentifiable {
	@objc dynamic var sheetsId: String = ""
	@objc dynamic var title: String = ""
	
	convenience init(sheetsId: String, title: String) {
		self.init()
		self.sheetsId = sheetsId
		self.title = title
	}
	
}
