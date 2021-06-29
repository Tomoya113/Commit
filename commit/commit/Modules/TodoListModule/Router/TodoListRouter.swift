//
//  TodoListRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

class TodoListRouter {
	func generateDetailView(for todo: Todo, repository: TodoRepositoryProtocol) -> some View {
		let dependency = TodoDetailPresenter.Dependency()
		let presenter = TodoDetailPresenter(dependency: dependency, todo: todo)
		return TodoDetailView(presenter: presenter)
	}
}
