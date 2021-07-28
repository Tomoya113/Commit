//
//  SettingsView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import SwiftUI

struct SettingsView: View {
	@ObservedObject var presenter: SettingsPresenter
	@State private var showTermsOfService = false
	@State private var showPrivacyPolicy = false
    var body: some View {
		NavigationView {
			List {
				presenter.createGoogleOAuthSettingView {
					Text("Googleアカウント連携")
				}
				Button(action: {
					showTermsOfService.toggle()
				}, label: {
					Text("利用規約")
				})
				Button(action: {
					showPrivacyPolicy.toggle()
				}, label: {
					Text("プライバシーポリシー")
				})
			}
			.navigationTitle(Text("設定"))
			.sheet(isPresented: $showTermsOfService) {
				SafariView(url: CommitSiteURL.termsOfService.url)
			}
			.sheet(isPresented: $showPrivacyPolicy) {
				SafariView(url: CommitSiteURL.privacyPolicy.url)
			}
			.listStyle(PlainListStyle())
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(presenter: SettingsPresenter())
    }
}
