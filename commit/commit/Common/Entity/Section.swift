//
//  Section.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/10.
//

import Foundation
import RealmSwift

class SectionRealm: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var title: String = ""
	let todos = List<Todo>()

	convenience init(title: String, todos: [Todo]) {
		self.init()
		self.title = title
		self.todos.append(objectsIn: todos)
	}
	override static func primaryKey() -> String? {
		return "id"
	}
}
