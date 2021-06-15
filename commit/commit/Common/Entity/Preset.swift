//
//  SpreadSheetPreset.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class Preset: Object {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var spreadSheetId: String = ""
	@objc dynamic var sheetId: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var range: SheetRange?
	
	static override func primaryKey() -> String? {
		return "id"
	}
}

class SheetRange: EmbeddedObject {
	@objc dynamic var row: SheetRow?
	@objc dynamic var column: SheetColumn?
}

class SheetRow: EmbeddedObject {
	@objc dynamic var start: String = ""
	@objc dynamic var end: String = ""
}

class SheetColumn: EmbeddedObject {
	@objc dynamic var start: String = ""
	@objc dynamic var end: String = ""
}


