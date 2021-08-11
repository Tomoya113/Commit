//
//  SettingsView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import SwiftUI

struct SettingsView: View {
	@ObservedObject var presenter: SettingsPresenter
    var body: some View {
		NavigationView {
			List {
				presenter.createGoogleOAuthSettingView {
					Text("Googleアカウント連携")
				}
				presenter.createExternalLinkURLLink(title: "利用規約", siteType: CommitSiteURL.termsOfService)
				presenter.createExternalLinkURLLink(title: "プライバシーポリシー", siteType: CommitSiteURL.privacyPolicy)
				presenter.createExternalLinkURLLink(title: "お問合せフォーム", siteType: CommitSiteURL.inquiryForm)
			}
			.navigationTitle(Text("設定"))
			.listStyle(PlainListStyle())
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(presenter: SettingsPresenter())
    }
}
