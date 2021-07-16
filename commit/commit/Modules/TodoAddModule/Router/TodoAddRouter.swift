//
//  TodoAddRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import SwiftUI

class TodoAddRouter {
	func generateNormalTodoAddView(sections: Binding<[SectionRealm]>) -> some View {
		let todoCreateInteractor = AnyUseCase(TodoCreateInteractor(repository: TodoRepository.shared))
		let dependency: NormalTodoAddPresenter.Dependency = NormalTodoAddPresenter.Dependency(todoCreateInteractor: todoCreateInteractor)
		let presenter = NormalTodoAddPresenter(dependency: dependency)
		return NormalTodoAddView(presenter: presenter, sections: sections)
	}
	
	func generateSpreadSheetAddView() -> some View {
		let spreadSheetCellsFetchInteractor = AnyUseCase(CellsFetchInteractor())
		let spreadSheetFilesFetchInteractor = AnyUseCase(SpreadSheetFilesFetchInteractor())
		let spreadSheetInfoFetchInteractor = AnyUseCase(SpreadSheetInfoFetchInteractor())
		let dependency = SpreadSheetAddPresenter.Dependency(
			spreadSheetCellsFetchInteractor: spreadSheetCellsFetchInteractor,
			spreadSheetFilesFetchInteractor: spreadSheetFilesFetchInteractor,
			spreadSheetInfoFetchInteractor: spreadSheetInfoFetchInteractor
		)
		let presenter: SpreadSheetAddPresenter = SpreadSheetAddPresenter(dependency: dependency)
		return SpreadSheetAddView(presenter: presenter)
	}
}
