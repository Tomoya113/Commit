//
//  Repository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation

protocol Repository {
	func findTodosById(_ id: String) -> [Todo]
	func fetchLists() -> [ListRealm]
	func updateTodoStatusById(_ id: String)
}
