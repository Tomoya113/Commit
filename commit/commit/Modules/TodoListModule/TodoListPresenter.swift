//
//  TodoListPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import Foundation

class TodoListPresenter: ObservableObject {
	
	@Published var list: ListRealm?
	@Published var todos: [TodoProtocol] = []
	
	
}
