//
//  Repository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation
import RealmSwift

protocol Repository {
	func findTodosById(_ id: String, completion: ((Result<[Todo], Never>) -> Void )?)
	func fetchLists(completion: ((Result<[ListRealm], Never>) -> Void )?)
	func updateTodoStatusById(_ id: String)
}
