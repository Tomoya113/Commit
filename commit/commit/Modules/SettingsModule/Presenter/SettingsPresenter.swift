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
	case inquiryForm = "https://forms.gle/EWkb1jo7EyozDSZW8"
	var url: URL {
		URL(string: self.rawValue)!
	}
}

class SettingsPresenter: ObservableObject {
	let router = SettingsRouter()
	
	func createExternalLinkURLLink(title: String, siteType: CommitSiteURL) -> some View {
		return (
			NavigationLink(
				destination: WebView(url: siteType.url)
					.navigationBarTitleDisplayMode(.inline)
					.navigationBarTitle(Text(title))
				,
				label: {
					Text(title)
				})
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
