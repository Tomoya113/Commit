//
//  TodoAddRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import SwiftUI

class TodoAddRouter {
	func generateNormalTodoAddView(sections: Binding<[SectionRealm]>) -> some View {
		let todoCreateInteractor = AnyUseCase(TodoCreateInteractor())
		let sectionAddInteractor = AnyUseCase(SectionAddInteractor())
		let fetchAllSectionInteractor = AnyUseCase(FetchAllSectionsInteractor())
		let dependency: NormalTodoAddPresenter.Dependency = NormalTodoAddPresenter.Dependency(
			todoCreateInteractor: todoCreateInteractor,
			sectionAddInteractor: sectionAddInteractor, fetchAllSectionsInteractor: fetchAllSectionInteractor
		)
		let presenter = NormalTodoAddPresenter(dependency: dependency)
		return NormalTodoAddView(presenter: presenter)
	}
	
	func generateSheetsTodoAddView() -> some View {
		let sheetsCellsFetchInteractor = AnyUseCase(SheetsCellsFetchInteractor())
		let sheetsFilesFetchInteractor = AnyUseCase(SheetsFilesFetchInteractor())
		let sheetsInfoFetchInteractor = AnyUseCase(SheetsInfoFetchInteractor())
		let createSheetDataInteractor = AnyUseCase(CreateSheetDataInteractor())
		let dependency = SheetsAddPresenter.Dependency(
			sheetsCellsFetchInteractor: sheetsCellsFetchInteractor,
			sheetsFilesFetchInteractor: sheetsFilesFetchInteractor,
			sheetsInfoFetchInteractor: sheetsInfoFetchInteractor,
			createSheetsDataInteractor: createSheetDataInteractor
		)
		let presenter: SheetsAddPresenter = SheetsAddPresenter(dependency: dependency)
		return SheetsTodoAddView(presenter: presenter)
	}
}
