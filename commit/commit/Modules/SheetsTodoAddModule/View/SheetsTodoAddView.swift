//

//  SheetsTodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct SheetsTodoAddView: View {
	@StateObject var presenter: SheetsAddPresenter
	@EnvironmentObject var googleDelegate: GoogleOAuthManager

	var body: some View {
		// NOTE: この書き方やめろ
		if googleDelegate.authenticated {
			SheetsTodoAddFormView(
				sheetsPreset: $presenter.sheetPreset,
				userResources: $presenter.userResources,
				sheetData: $presenter.sheetData,
				fetchSheetsInfo: presenter.fetchSheetsInfo,
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

struct SheetsTodoAddView_Previews: PreviewProvider {
	static var previews: some View {
		SheetsTodoAddView(presenter: SheetsAddPresenter.sample)
	}
}
#endif
