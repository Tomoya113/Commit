//
//  SpreadSheetView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct SpreadSheetAddView: View {
	@StateObject var presenter: SheetsAddPresenter
	@EnvironmentObject var googleDelegate: GoogleOAuthManager

	var body: some View {
		// NOTE: この書き方やめろ
		if googleDelegate.authenticated {
			SpreadSheetFormView(
				spreadSheetPreset: $presenter.sheetPreset,
				userResources: $presenter.userResources,
				sheetData: $presenter.sheetData,
				fetchSpreadSheetInfo: presenter.fetchSpreadSheetInfo,
				fetchCells: presenter.fetchCells,
				saveData: presenter.saveData
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

#if DEBUG

struct SpreadSheetView_Previews: PreviewProvider {
	static var previews: some View {
		SpreadSheetAddView(presenter: SheetsAddPresenter.sample)
	}
}
#endif
