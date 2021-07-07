//
//  SpreadSheetView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI
// NOTE: 後で消す
import GoogleSignIn

struct SpreadSheetAddView: View {
	@ObservedObject var presenter: SpreadSheetAddPresenter
	@State var text: String = ""
	var body: some View {
		if presenter.authenticated {
			Form {
				Section(header: Text("スプレッドシート名")) {
					TextField("タスク名", text: $text)
				}
				Section(header: Text("シート名")) {
					TextField("シート名", text: $text)
				}
				Section(header: Text("セクション名")) {
					TextField("セクション名", text: $text)
				}
				Section(header: Text("行")) {
					TextField("行", text: $text)
				}
				Section(header: Text("列")) {
					TextField("最初", text: $text)
					TextField("最後", text: $text)
				}
			}
		} else {
			VStack {
				Button(action: {
					presenter.googleOAuth()
				}, label: {
					Text("SignIn")
				})
			}
			.onAppear {
				GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
			}
		}
	}
}

struct SpreadSheetView_Previews: PreviewProvider {
    static var previews: some View {
		SpreadSheetAddView(presenter: SpreadSheetAddPresenter())
    }
}
