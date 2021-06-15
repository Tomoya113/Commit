//
//  Tag.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class TodoTag: Object {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var title: String = ""
	@objc dynamic var color: String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
