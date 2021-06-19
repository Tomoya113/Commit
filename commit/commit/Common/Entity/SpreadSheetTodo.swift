//
//  SpreadSheetTodo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class SpreadSheetTodo: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var presetId: String = ""
	@objc dynamic var content: Todo?
	@objc dynamic var row: String = ""
	@objc dynamic var column: String = ""

	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience init(id: String, presetId: String, content: Todo, row: String, column: String) {
		self.init()
		self.id = id
		self.presetId = presetId
		self.content = content
		self.row = row
		self.column = column
	}
	
}
