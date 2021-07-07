//
//  SpreadSheetPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation
import GoogleSignIn

class SpreadSheetAddPresenter: ObservableObject {
	@Published var authenticated: Bool = GoogleOAuthManager.shared.authenticated
	@Published var token: String = GoogleOAuthManager.shared.token
	
	func googleOAuth() {
		GIDSignIn.sharedInstance()?.signIn()
	}
	
}

#if DEBUG
extension SpreadSheetAddPresenter {
	static let sample: SpreadSheetAddPresenter = {
		return SpreadSheetAddPresenter()
	}()
}
#endif
