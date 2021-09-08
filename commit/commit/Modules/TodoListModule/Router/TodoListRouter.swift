//
//  TodoListRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

protocol TodoListWireframe {
	func generateDetailView(for todo: Todo) -> TodoDetailView
	func generateTodoAddView() -> TodoAddView
}

class TodoListRouter: TodoListWireframe {
	
	func generateDetailView(for todo: Todo) -> TodoDetailView {
		let deleteTodoInteractor = AnyUseCase(DeleteTodoInteractor())
		let fetchSheetsCellInteractor = AnyUseCase(FetchSheetsCellInteractor())
		let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor())
		let writeSheetsInteractor = AnyUseCase(WriteSheetsInteractor())
		let dependency = TodoDetailPresenter.Dependency(
			deleteTodoInteractor: deleteTodoInteractor,
			fetchSheetsCellInteractor: fetchSheetsCellInteractor,
			todoUpdateInteractor: todoUpdateInteractor,
			writeSheetsInteractor: writeSheetsInteractor
		)
		let presenter = TodoDetailPresenter(dependency: dependency, todo: todo)
		return TodoDetailView(presenter: presenter)
	}
	
	func generateTodoAddView() -> TodoAddView {
		let currentListFetchInteractor = CurrentListFetchInteractor()
		let dependency = TodoAddPresenter.Dependency(currentListFetchInteractor: AnyUseCase(currentListFetchInteractor))
		let presenter = TodoAddPresenter(dependency: dependency)
		return TodoAddView(presenter: presenter)
	}
}
