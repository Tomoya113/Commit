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
		List {
			NavigationLink(
				destination: Text("Destination"),
				label: {
					Text("Googleアカウント連携")
				}
			)
			presenter.createWebView(siteType: .termsOfService) {
				Text("利用規約")
			}
			presenter.createWebView(siteType: .privacyPolicy) {
				Text("プライバシーポリシー")
			}
		}
		.navigationTitle(Text("設定"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			SettingsView(presenter: SettingsPresenter())
		}
    }
}
