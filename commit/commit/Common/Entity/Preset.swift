//
//  Preset.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class Preset: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var sectionId: String = ""
	@objc dynamic var sheetsId: String = ""
	@objc dynamic var tabName: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var range: SheetRange?
	// 書き込む行
	@objc dynamic var targetRow: String = ""
	
	static override func primaryKey() -> String? {
		return "id"
	}
	
	convenience init(sheetId: String, sectionId: String, tabName: String, title: String, range: SheetRange, targetRow: String) {
		self.init()
		self.sheetsId = sheetId
		self.sectionId = sectionId
		self.tabName = tabName
		self.title = title
		self.range = range
		self.targetRow = targetRow
	}
}

class SheetRange: EmbeddedObject {
	@objc dynamic var row: String = ""
	@objc dynamic var column: SheetColumn?
	
	convenience init(row: String, column: SheetColumn) {
		self.init()
		self.row = row
		self.column = column
	}
}

class SheetColumn: EmbeddedObject {
	@objc dynamic var start: String = ""
	@objc dynamic var end: String = ""
	
	convenience init(start: String, end: String) {
		self.init()
		self.start = start
		self.end = end
	}
}
