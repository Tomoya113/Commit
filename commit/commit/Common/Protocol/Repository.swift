//
//  Repository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

protocol Repository {
	func findTodosById(_ id: String) -> [TodoProtocol]
	func fetchLists() -> [ListRealm]
	func updateNormalTodoStatusById(_ id: String)
}
