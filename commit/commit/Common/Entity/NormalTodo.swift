//
//  NormalTodo.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class NormalTodo: Object {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var content: Todo?
}
