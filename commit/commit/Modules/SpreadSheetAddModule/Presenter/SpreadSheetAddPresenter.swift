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

class SheetData: ObservableObject {
	@Published var preset: Preset = Preset()
	@Published var section: SectionRealm = SectionRealm()
	@Published var sheetsTodoAttributes: [SheetsTodoAttribute] = []
}

class SpreadSheetAddPresenter: ObservableObject {
	struct Dependency {
		let spreadSheetCellsFetchInteractor: AnyUseCase<FetchSheetCellsQuery, [String], Error>
		let spreadSheetFilesFetchInteractor: AnyUseCase<String, [SpreadSheetFile], Error>
		let spreadSheetInfoFetchInteractor: AnyUseCase<String, [Sheet], Error>
		let createSheetDataInteractor: AnyUseCase<CreateSheetDataQuery, Void, Error>
	}
	
	@Published var sheetPreset = SheetPreset()
	@Published var userResources = UserResources()
	@Published var sheetData = SheetData()
	
	let dependency: SpreadSheetAddPresenter.Dependency
	
	init(
		dependency: SpreadSheetAddPresenter.Dependency
	) {
		self.dependency = dependency
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
	
	func saveData() {
		if sheetData.sheetsTodoAttributes.isEmpty {
			print("attribute not found")
			return
		}
		let createSheetDataQuery = CreateSheetDataQuery(
			preset: sheetData.preset, section: sheetData.section, sheetsAttributes: sheetData.sheetsTodoAttributes)
		dependency.createSheetDataInteractor.execute(createSheetDataQuery, completion: nil)
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
		
		let columnRange = SheetColumnEnum.getRange(
			sheetPreset.column.start!,
			sheetPreset.column.end!
		)
		
		sheetData.section.title = sheetPreset.title
		
		sheetData.preset.spreadSheetId = sheetPreset.spreadSheetId
		sheetData.preset.sectionId = sheetData.section.id
		sheetData.preset.tabName = sheetPreset.tabName
		sheetData.preset.title = sheetPreset.title
		sheetData.preset.range = sheetRange
		sheetData.preset.targetRow = sheetPreset.targetRow
		
		for i in 0..<cells.count {
			let todo: Todo = Todo(
				title: cells[i].removeWhitespacesAndNewlines,
				detail: "",
				displayTag: [],
				todoType: .googleSheets)
			sheetData.section.todos.append(todo)

			let sheetsTodoAttribute = SheetsTodoAttribute(todoId: todo.id, presetId: sheetData.preset.id, column: columnRange[i].rawValue)
			sheetData.sheetsTodoAttributes.append(sheetsTodoAttribute)
		}
	}
	
}

#if DEBUG
extension SpreadSheetAddPresenter {
	static let sample: SpreadSheetAddPresenter = {
		let spreadSheetCellsFetchInteractor = AnyUseCase(CellsFetchInteractor())
		let spreadSheetFilesFetchInteractor = AnyUseCase(SpreadSheetFilesFetchInteractor())
		let spreadSheetInfoFetchInteractor = AnyUseCase(SpreadSheetInfoFetchInteractor())
		let createSheetDataInteractor = AnyUseCase(CreateSheetDataInteractor())
		let dependency = Dependency(
			spreadSheetCellsFetchInteractor: spreadSheetCellsFetchInteractor,
			spreadSheetFilesFetchInteractor: spreadSheetFilesFetchInteractor,
			spreadSheetInfoFetchInteractor: spreadSheetInfoFetchInteractor,
			createSheetDataInteractor: createSheetDataInteractor
		)
		return SpreadSheetAddPresenter(dependency: dependency)
	}()
}
#endif
