//
//  SpreadSheetPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation
import GoogleSignIn

class Column: ObservableObject {
	@Published var start: String = ""
	@Published var end: String = ""
}
// NOTE: 命名微妙じゃない？
class SpreadSheetPreset: ObservableObject {
	@Published var spreadSheetId: String = ""
	@Published var title: String = ""
	@Published var tabName: String = ""
	@Published var column: Column = Column()
	@Published var row: String = ""
}

class UserResources: ObservableObject {
	@Published var spreadSheetList: [SpreadSheetFile] = []
	@Published var tabList: [SheetProperties] = []
}

class SpreadSheetAddPresenter: ObservableObject {
	struct Dependency {
		let spreadSheetCellsFetchInteractor: AnyUseCase<FetchSpreadSheetCellsQuery, [String], Error>
		let spreadSheetFilesFetchInteractor: AnyUseCase<String, [SpreadSheetFile], Error>
		let spreadSheetInfoFetchInteractor: AnyUseCase<String, [Sheet], Error>
	}
	
	@Published var spreadSheetPreset = SpreadSheetPreset()
	@Published var userResources = UserResources()
	
	let dependency: SpreadSheetAddPresenter.Dependency
	
	init(dependency: SpreadSheetAddPresenter.Dependency) {
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
	
	func fetchSpreadSheetCells() {
		let column = QueryColumn(
			start: spreadSheetPreset.column.start,
			end: spreadSheetPreset.column.end
		)
		let query = FetchSpreadSheetCellsQuery(
			sheetName: spreadSheetPreset.tabName,
			spreadSheetId: spreadSheetPreset.spreadSheetId,
			column: column,
			row: spreadSheetPreset.row
		)
		dependency.spreadSheetCellsFetchInteractor.execute(query) { result in
			switch result {
				case .success(let cells):
					print(cells)
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	func fetchSpreadSheetInfo() {
		dependency.spreadSheetInfoFetchInteractor.execute(spreadSheetPreset.spreadSheetId) { result in
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
}

#if DEBUG
extension SpreadSheetAddPresenter {
	static let sample: SpreadSheetAddPresenter = {
		let spreadSheetCellsFetchInteractor = AnyUseCase(SpreadSheetCellsFetchInteractor())
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
