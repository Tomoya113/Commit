//
//  GoogleAccountSettingPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import Foundation
import GoogleSignIn
import Combine

class GoogleAccountSettingAlert: ObservableObject {
	@Published var title = ""
	@Published var message = ""
	@Published var confirmText = ""
	@Published var cancelText = ""
}

class GoogleAccountSettingPresenter: ObservableObject, GoogleOAuthManagerProtocol {
	
	@Published var hasPreviousSignIn: Bool = GoogleOAuthManager.shared.authenticated
	@Published var isPresented: Bool = false
	@Published var alert = GoogleAccountSettingAlert()
	@Published var isCancelled = false
	private var cancellables: Set<AnyCancellable> = Set()
	
	init() {
		$hasPreviousSignIn
			.dropFirst(1)
			.sink { value in
				if !self.isCancelled {
					self.isPresented = true
					self.setAlertMessage(value)
				}
			}
			.store(in: &cancellables)
		GoogleOAuthManager.shared.delegate = self
	}

	func onAppear() {
		GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
	}
	
	func confirm() {
		if hasPreviousSignIn {
			// 未連携→連携の時
			GIDSignIn.sharedInstance()?.signIn()
		} else {
			// 連携→未連携の時
			GoogleOAuthManager.shared.signOut()
		}
	}
	
	func cancel() {
		hasPreviousSignIn.toggle()
		isPresented = false
	}
	
	private func setAlertMessage(_ hasPreviousSignIn: Bool) {
		if hasPreviousSignIn {
			// 連携する？
			alert.title = "Googleアカウント連携"
			alert.message = "アプリにGoogleアカウントを連携させますか？"
			alert.confirmText = "連携する"
			alert.cancelText = "キャンセル"
		} else {
			// 解除する？
			alert.title = "Googleアカウント連携の解除"
			alert.message = "アプリとGoogleアカウントの連携を解除させますか？"
			alert.confirmText = "解除する"
			alert.cancelText = "キャンセル"
		}
	}
	
	func didSigninCancelled() {
		// NOTE, HELL: ここのコード地獄すぎ
		isCancelled = true
		hasPreviousSignIn = GoogleOAuthManager.shared.authenticated
		isCancelled = false
	}
	
}
