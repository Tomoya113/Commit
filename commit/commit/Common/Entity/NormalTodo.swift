//
//  NormalTodo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class NormalTodo: Object, ObjectKeyIdentifiable {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var content: Todo?
	
	convenience init(todo: Todo) {
		self.init()
		self.content = todo
	}
}
