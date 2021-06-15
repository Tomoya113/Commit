//
//  Todo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class DisplayTag: EmbeddedObject {
	@objc dynamic var tagId: String = ""
}

class TodoStatus: EmbeddedObject {
	@objc dynamic var finished: Bool = false
	@objc dynamic var detail: String = ""
}

class Todo: EmbeddedObject {
	@objc dynamic var sectionId: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var status: TodoStatus?
	let tags = RealmSwift.List<DisplayTag>()

	convenience init(detail: String, sectionId: String, tags: [DisplayTag], title: String) {
		self.init()
		self.sectionId = sectionId
		self.title = title
		self.status?.detail = detail
		self.tags.append(objectsIn: tags)
	}
}
