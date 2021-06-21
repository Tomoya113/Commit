//
//  Todo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class DisplayTag: EmbeddedObject {
	@objc dynamic var tagId: String = ""
	
	convenience init(tagId: String) {
		self.init()
		self.tagId = tagId
	}
}

class TodoStatus: EmbeddedObject {
	@objc dynamic var finished: Bool = false
	@objc dynamic var detail: String = ""
	
	convenience init(finished: Bool, detail: String) {
		self.init()
		self.finished = finished
		self.detail = detail
	}
}

class Todo: EmbeddedObject {
	
	@objc dynamic var sectionId: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var status: TodoStatus?
	let tags = List<DisplayTag>()
	
	convenience init(sectionId: String, title: String, detail: String = "", displayTag: [DisplayTag]) {
		self.init()
		self.sectionId = sectionId
		self.title = title
		self.status = TodoStatus(finished: false, detail: detail)
		tags.append(objectsIn: displayTag)
	}

}

protocol TodoProtocol {
	var content: Todo? { get set }
}
