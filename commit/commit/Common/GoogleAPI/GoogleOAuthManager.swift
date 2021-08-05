//
//  GoogleAPIDelegate.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/06.
//

import Foundation
import GoogleSignIn

protocol GoogleOAuthManagerProtocol: AnyObject {
	func didSigninCancelled()
}

class GoogleOAuthManager: NSObject, GIDSignInDelegate, ObservableObject {
	@Published var authenticated: Bool = false
	@Published var token: String = ""
	@Published var email: String = ""
	// デリゲートが入れ子になっているので良くない気がする
	weak var delegate: GoogleOAuthManagerProtocol?
	static let shared = GoogleOAuthManager()
	
	override init() {
		super.init()
		GIDSignIn.sharedInstance().clientID = GoogleAPIInfo.CLIENT_ID
		GIDSignIn.sharedInstance().scopes = GoogleAPIInfo.scopes
		GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
		
	}
	
	static func signIn() {
		if GIDSignIn.sharedInstance().hasPreviousSignIn() {
			GIDSignIn.sharedInstance().restorePreviousSignIn()
		}
	}
	
	func signOut() {
		email = ""
		authenticated = false
		GIDSignIn.sharedInstance().signOut()
	}
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if let error = error {
			// NOTE: ここで良いのか怪しいので後々変える
			delegate?.didSigninCancelled()
			if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
				print("The user has not signed in before or they have since signed out.")
			} else if (error as NSError).code == GIDSignInErrorCode.canceled.rawValue {
				print("Signin cancelled")
				
			} else {
				print("\(error.localizedDescription)")
			}
			return
		}
		
		authenticated = true
		token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
		email = GIDSignIn.sharedInstance().currentUser.profile.email
	}
	
}
