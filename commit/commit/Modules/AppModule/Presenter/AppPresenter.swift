//
//  AppPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/06.
//

import Foundation
import SwiftUI

class AppPresenter: ObservableObject {
	let router: AppRouter = AppRouter()
	
	func todoListView() -> some View {
		return (
			NavigationView {
				router.generateTodoListView()
			}
			.navigationViewStyle(StackNavigationViewStyle())
		)
	}
	
	func settingsView() -> some View {
		return router.generateSettingsView()
	}
}
