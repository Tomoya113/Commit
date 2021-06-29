//
//  List.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class ListRealm: Object, ObjectKeyIdentifiable {
	@objc dynamic var title: String = ""
	let sections = List<SectionRealm>()
	
	convenience init(title: String, sections: [SectionRealm]) {
		self.init()
		self.title = title
		self.sections.append(objectsIn: sections)
	}
	
}

class SectionRealm: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var title: String = ""
	let todos = List<Todo>()

	convenience init(title: String, todos: [Todo]) {
		self.init()
		self.title = title
		self.todos.append(objectsIn: todos)
	}
}
