//
//  SpreadSheetPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation
import GoogleSignIn

class Column: ObservableObject {
	@Published var start: SheetColumnEnum?
	@Published var end: SheetColumnEnum?
}
// NOTE: 命名微妙じゃない？
class SheetPreset: ObservableObject {
	@Published var spreadSheetId: String = ""
	@Published var title: String = ""
	@Published var tabName: String = ""
	@Published var column: Column = Column()
	@Published var row: String = ""
	@Published var targetRow: String = ""
}

class UserResources: ObservableObject {
	@Published var spreadSheetList: [SpreadSheetFile] = []
	@Published var tabList: [SheetProperties] = []
}

class SpreadSheetAddPresenter: ObservableObject {
	struct Dependency {
		let spreadSheetCellsFetchInteractor: AnyUseCase<FetchSheetCellsQuery, [String], Error>
		let spreadSheetFilesFetchInteractor: AnyUseCase<String, [SpreadSheetFile], Error>
		let spreadSheetInfoFetchInteractor: AnyUseCase<String, [Sheet], Error>
	}
	
	@Published var sheetPreset = SheetPreset()
	@Published var userResources = UserResources()
	
	let dependency: SpreadSheetAddPresenter.Dependency
	let todoRepository: TodoRepositoryProtocol
	let sheetRepository: SheetRepositoryProtocol
	
	init(
		dependency: SpreadSheetAddPresenter.Dependency,
		todoRepository: TodoRepositoryProtocol = TodoRepository.shared,
		sheetRepository: SheetRepositoryProtocol = SheetRepository()
	) {
		self.dependency = dependency
		self.todoRepository = todoRepository
		self.sheetRepository = sheetRepository
	}
	
	func googleOAuth() {
		GIDSignIn.sharedInstance()?.signIn()
	}
	
	func onAppear() {
		if userResources.spreadSheetList.isEmpty {
			fetchSpreadSheetFiles()
		}
	}
	
	func setPresentingViewController() {
		GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
	}
	
	func fetchSpreadSheetFiles() {
		dependency.spreadSheetFilesFetchInteractor.execute("") { result in
			switch result {
				case .success(let files):
					DispatchQueue.main.async {
						// NOTE: もうちょっと良い書き方ありそう
						self.objectWillChange.send()
						self.userResources.spreadSheetList = files
					}
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	func fetchCells() {
		let fetchSheetCellsQuery = generateFetchSheetCellsQuery()
		dependency.spreadSheetCellsFetchInteractor.execute(fetchSheetCellsQuery) { result in
			switch result {
				case .success(let cells):
					self.createData(cells: cells)
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	func fetchSpreadSheetInfo() {
		// NOTE: 後で書き換える
		dependency.spreadSheetInfoFetchInteractor.execute(sheetPreset.spreadSheetId) { result in
			switch result {
				case .success(let sheets):
					DispatchQueue.main.async {
						// NOTE: もうちょっと良い書き方ありそう
						self.objectWillChange.send()
						let sheetProperties = sheets.map { $0.properties }
						self.userResources.tabList = sheetProperties
					}
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	private func generateFetchSheetCellsQuery() -> FetchSheetCellsQuery {
		// NOTE: !やめる
		let column = QueryColumn(
			start: sheetPreset.column.start!.rawValue,
			end: sheetPreset.column.end!.rawValue
		)
		let query = FetchSheetCellsQuery(
			sheetName: sheetPreset.tabName,
			// NOTE: 後で書き換える
			spreadSheetId: sheetPreset.spreadSheetId,
			column: column,
			row: sheetPreset.row
		)
		return query
	}
	
	private func createData(cells: [String]) {
		let sheetColumn = SheetColumn(
			start: sheetPreset.column.start!.rawValue,
			end: sheetPreset.column.end!.rawValue
		)
		let sheetRange = SheetRange(
			row: sheetPreset.row,
			column: sheetColumn
		)
		let preset: Preset = Preset(
			spreadSheetId: sheetPreset.spreadSheetId,
			tabName: sheetPreset.tabName,
			title: sheetPreset.title,
			range: sheetRange,
			targetRow: sheetPreset.targetRow)
		sheetRepository.createPreset(preset)
		
		let section: SectionRealm = SectionRealm(title: sheetPreset.title, todos: [])
		todoRepository.createNewSection(section: section)
		let columnRange = SheetColumnEnum.getRange(
			sheetPreset.column.start!,
			sheetPreset.column.end!
		)
		
		for i in 0..<cells.count {
			let todo: Todo = Todo(
				title: cells[i].removeWhitespacesAndNewlines,
				detail: "",
				displayTag: [],
				todoType: .googleSheets)
			let todoQuery: AddTodoQuery = AddTodoQuery(
				sectionId: section.id,
				todo: todo
			)
			todoRepository.createNewTodo(
				query: todoQuery) { _ in
				
			}
			let sheetTodoQuery = SheetTodoQuery(
				todoId: todo.id,
				presetId: preset.id,
				column: columnRange[i].rawValue
			)
			sheetRepository.createSheetTodoAttribute(sheetTodoQuery)
		}
	}
	
}

#if DEBUG
extension SpreadSheetAddPresenter {
	static let sample: SpreadSheetAddPresenter = {
		let spreadSheetCellsFetchInteractor = AnyUseCase(CellsFetchInteractor())
		let spreadSheetFilesFetchInteractor = AnyUseCase(SpreadSheetFilesFetchInteractor())
		let spreadSheetInfoFetchInteractor = AnyUseCase(SpreadSheetInfoFetchInteractor())
		let dependency = Dependency(
			spreadSheetCellsFetchInteractor: spreadSheetCellsFetchInteractor,
			spreadSheetFilesFetchInteractor: spreadSheetFilesFetchInteractor,
			spreadSheetInfoFetchInteractor: spreadSheetInfoFetchInteractor
		)
		return SpreadSheetAddPresenter(dependency: dependency)
	}()
}
#endif
