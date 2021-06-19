//
//  Tag.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class TodoTag: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var title: String = ""
	@objc dynamic var color: String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
//	NOTE: 後にcolorをenumにする
	convenience init(title: String, color: String) {
		self.init()
		self.title = title
		self.color = color
	}
}
