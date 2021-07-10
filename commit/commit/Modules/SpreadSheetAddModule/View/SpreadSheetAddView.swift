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
			SpreadSheetFormView(spreadSheetPreset: $presenter.spreadSheetPreset, spreadSheetList: presenter.userResources.spreadSheetList)
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
