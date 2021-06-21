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
	@objc dynamic var row: String = ""
	@objc dynamic var column: String = ""
}
