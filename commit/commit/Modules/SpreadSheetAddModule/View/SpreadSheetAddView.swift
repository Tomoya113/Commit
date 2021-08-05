//
//  SpreadSheetView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct SpreadSheetAddView: View {
	@ObservedObject var presenter: SpreadSheetAddPresenter
	@EnvironmentObject var googleDelegate: GoogleOAuthManager

	var body: some View {
		// NOTE: この書き方やめろ
		if googleDelegate.authenticated {
			SpreadSheetFormView(
				spreadSheetPreset: $presenter.sheetPreset,
				userResources: $presenter.userResources,
				fetchSpreadSheetInfo: presenter.fetchSpreadSheetInfo,
				fetchCells: presenter.fetchCells
			)
			.onAppear {
				presenter.onAppear()
			}
		} else {
			RequireGoogleOAuthView {
				presenter.googleOAuth()
			}
			.onAppear {
				presenter.setPresentingViewController()
			}
		}
	}
}

struct SpreadSheetView_Previews: PreviewProvider {
	static var previews: some View {
		SpreadSheetAddView(presenter: SpreadSheetAddPresenter.sample)
	}
}
