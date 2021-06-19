//
//  SpreadSheetPreset.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class Preset: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var spreadSheetId: String = ""
	@objc dynamic var sheetId: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var range: SheetRange?
	
	static override func primaryKey() -> String? {
		return "id"
	}
	
	convenience init( spreadSheetId: String, sheetId: String, title: String, range: SheetRange) {
		self.init()
		self.spreadSheetId = spreadSheetId
		self.sheetId = sheetId
		self.title = title
		self.range = range
	}
}

class SheetRange: EmbeddedObject {
	@objc dynamic var row: SheetRow?
	@objc dynamic var column: SheetColumn?
	
	convenience init(row: SheetRow, column: SheetColumn) {
		self.init()
		self.row = row
		self.column = column
	}
}

class SheetRow: EmbeddedObject {
	@objc dynamic var start: String = ""
	@objc dynamic var end: String = ""
	
	convenience init(start: String, end: String) {
		self.init()
		self.start = start
		self.end = end
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
