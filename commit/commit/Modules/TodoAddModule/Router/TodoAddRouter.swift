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
		let sectionAddInteractor = AnyUseCase(SectionAddInteractor())
		let fetchAllSectionInteractor = AnyUseCase(FetchAllSectionsInteractor())
		let dependency: NormalTodoAddPresenter.Dependency = NormalTodoAddPresenter.Dependency(
			todoCreateInteractor: todoCreateInteractor,
			sectionAddInteractor: sectionAddInteractor, fetchAllSectionsInteractor: fetchAllSectionInteractor
		)
		let presenter = NormalTodoAddPresenter(dependency: dependency)
		return NormalTodoAddView(presenter: presenter)
	}
	
	func generateSpreadSheetAddView() -> some View {
		let spreadSheetCellsFetchInteractor = AnyUseCase(CellsFetchInteractor())
		let spreadSheetFilesFetchInteractor = AnyUseCase(SpreadSheetFilesFetchInteractor())
		let spreadSheetInfoFetchInteractor = AnyUseCase(SpreadSheetInfoFetchInteractor())
		let createSheetDataInteractor = AnyUseCase(CreateSheetDataInteractor())
		let dependency = SpreadSheetAddPresenter.Dependency(
			spreadSheetCellsFetchInteractor: spreadSheetCellsFetchInteractor,
			spreadSheetFilesFetchInteractor: spreadSheetFilesFetchInteractor,
			spreadSheetInfoFetchInteractor: spreadSheetInfoFetchInteractor,
			createSheetDataInteractor: createSheetDataInteractor
		)
		let presenter: SpreadSheetAddPresenter = SpreadSheetAddPresenter(dependency: dependency)
		return SpreadSheetAddView(presenter: presenter)
	}
}
