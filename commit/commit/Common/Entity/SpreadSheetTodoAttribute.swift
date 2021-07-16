//
//  SpreadSheetTodoAttribute.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/22.
//

import Foundation
import RealmSwift

class SpreadSheetTodoAttribute: Object {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var todoId: String = ""
	@objc dynamic var presetId: String = ""
	@objc dynamic var column: String = ""
	
	convenience init(todoId: String, presetId: String, column: String) {
		self.init()
		self.todoId = todoId
		self.presetId = presetId
		self.column = column
	}
	
	static override func primaryKey() -> String? {
		return "id"
	}
}
