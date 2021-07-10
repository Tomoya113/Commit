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
	@Published var sheetList: [String] = []
}

class SpreadSheetAddPresenter: ObservableObject {
	
	@Published var authenticated: Bool = false
	@Published var token: String = ""
	@Published var spreadSheetPreset = SpreadSheetPreset()
	@Published var userResources = UserResources()
	
	func googleOAuth() {
		GIDSignIn.sharedInstance()?.signIn()
	}
	
	func onAppear() {
		authenticated = GoogleOAuthManager.shared.authenticated
		token = GoogleOAuthManager.shared.token
	}
	
}

#if DEBUG
extension SpreadSheetAddPresenter {
	static let sample: SpreadSheetAddPresenter = {
		return SpreadSheetAddPresenter()
	}()
}
#endif
