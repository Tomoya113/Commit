//
//  SettingsPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import Foundation
// NOTE: PresenterにSwiftUIインポートして良いのか怪しい
import SwiftUI

enum CommitSiteURL: String {
	case termsOfService = "https://www.commit-dev.site/terms-of-service"
	case privacyPolicy = "https://www.commit-dev.site/privacy-policy"
	var url: URL {
		URL(string: self.rawValue)!
	}
}

class SettingsPresenter: ObservableObject {
	let router = SettingsRouter()
	
	func createWebView<Content: View>(siteType: CommitSiteURL, @ViewBuilder content: () -> Content) -> some View {
		return (
			NavigationLink(
				destination: router.generateWebView(siteType: siteType)) {
					content()
			}
		)
	}
	
	func createGoogleOAuthSettingView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
		return (
			NavigationLink(
				destination: router.generateGoogleAccountSettingView()) {
					content()
			}
		)
	}
}
