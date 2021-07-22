//
//  TodoListRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

class TodoListRouter {
	func generateDetailView(for todo: Todo) -> some View {
		let deleteTodoInteractor = AnyUseCase(DeleteTodoInteractor())
		let fetchSheetsCellInteractor = AnyUseCase(FetchSheetsCellInteractor())
		let updateTodoInteractor = AnyUseCase(UpdateTodoInteractor())
		let writeSheetsInteractor = AnyUseCase(WriteSheetsInteractor())
		let dependency = TodoDetailPresenter.Dependency(
			deleteTodoInteractor: deleteTodoInteractor,
			fetchSheetsCellInteractor: fetchSheetsCellInteractor,
			updateTodoInteractor: updateTodoInteractor,
			writeSheetsInteractor: writeSheetsInteractor
		)
		let presenter = TodoDetailPresenter(dependency: dependency, todo: todo)
		return TodoDetailView(presenter: presenter)
	}
	
	func generateTodoAddView(sections: [SectionRealm]) -> some View {
		let currentListFetchInteractor = CurrentListFetchInteractor()
		let dependency = TodoAddPresenter.Dependency(currentListFetchInteractor: AnyUseCase(currentListFetchInteractor))
		let presenter = TodoAddPresenter(dependency: dependency)
		return TodoAddView(presenter: presenter)
	}
}
