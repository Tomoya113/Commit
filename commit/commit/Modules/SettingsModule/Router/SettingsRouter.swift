//
//  SettingsRouter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import Foundation
import SwiftUI

class SettingsRouter {	
	func generateGoogleAccountSettingView() -> some View {
		let presenter = GoogleAccountSettingPresenter()
		return (
			GoogleAccountSettingView(presenter: presenter)
		)
	}
	
	func generateWebView(siteType: CommitSiteURL) -> some View {
		return (
			SafariView(url: URL(string: siteType.rawValue)!)
		)
	}
}
