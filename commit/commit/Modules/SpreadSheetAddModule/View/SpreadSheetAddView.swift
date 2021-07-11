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
			SpreadSheetFormView(
				spreadSheetPreset: $presenter.spreadSheetPreset,
				spreadSheetList: presenter.userResources.spreadSheetList,
				sheetList: presenter.userResources.sheetList,
				fetchSpreadSheetInfo: presenter.fetchSpreadSheetInfo,
				fetchSpreadSheetCells: presenter.fetchSpreadSheetCells
			)
			.onAppear {
				// スプシのファイルを取得する
				presenter.fetchSpreadSheetFiles()
			}
		} else {
			VStack {
				Spacer()
				Button(action: {
					presenter.googleOAuth()
				}, label: {
					Text("SignIn")
				})
				Spacer()
			}
			.contentShape(Rectangle())
			.onAppear {
				GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
			}
		}
	}
}

struct SpreadSheetView_Previews: PreviewProvider {
	static var previews: some View {
		SpreadSheetAddView(presenter: SpreadSheetAddPresenter.sample)
	}
}
