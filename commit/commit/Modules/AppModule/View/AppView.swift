//
//  AppView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/29.
//

import SwiftUI

struct AppView: View {
	@ObservedObject var presenter: AppPresenter
    var body: some View {
		TabView {
			presenter.todoListView()
				.tabItem {
					Image(systemName: "checkmark.square")
					Text("Todo")
				}
			presenter.settingsView()
				.tabItem {
					Image(systemName: "gearshape")
					Text("設定")
				}
		}
		.environment(\.locale, Locale(identifier: "ja_JP"))
		.environmentObject(GoogleOAuthManager.shared)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(presenter: AppPresenter())
    }
}
