//
//  GoogleAccountSettingView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import SwiftUI

struct GoogleAccountSettingView: View {
	@ObservedObject var presenter: GoogleAccountSettingPresenter
	@EnvironmentObject var googleAccount: GoogleOAuthManager
    var body: some View {
		List {
			Toggle(isOn: $presenter.hasPreviousSignIn) {
				Text("アカウント連携")
			}
			HStack {
				Text("メールアドレス")
				Spacer()
				Text(googleAccount.email)
					.font(.subheadline)
					.foregroundColor(.gray)
			}
			.navigationTitle(Text("アカウント設定"))
		}
		.alert(isPresented: $presenter.isPresented, content: {
			alert()
		})
		.listStyle(GroupedListStyle())
		.onAppear {
			presenter.onAppear()
		}
    }
	
	private func alert() -> Alert {
		return (
			Alert(
				title: Text(presenter.alert.title),
				message: Text(presenter.alert.message),
				primaryButton: .destructive(
					Text(presenter.alert.cancelText),
					action: presenter.cancel
				),
				secondaryButton: .default(
					Text(presenter.alert.confirmText),
					action: presenter.confirm
				)
			)
		)
	}
}

struct GoogleAccountSettingView_Previews: PreviewProvider {
	static var presenter = GoogleAccountSettingPresenter()
    static var previews: some View {
		NavigationView {
			GoogleAccountSettingView(presenter: presenter)
				.navigationTitle(
					Text("Googleアカウント連携")
				)
		}
        
    }
}
