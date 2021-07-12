//
//  GoogleAPIDelegate.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/06.
//

import Foundation
import GoogleSignIn

class GoogleOAuthManager: NSObject, GIDSignInDelegate, ObservableObject {
	@Published var authenticated: Bool = false
	@Published var token: String = ""
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
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if let error = error {
		  if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
			print("The user has not signed in before or they have since signed out.")
		  } else {
			print("\(error.localizedDescription)")
		  }
		  return
		}
		
		print("logged in")
		authenticated = true
		token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
	}
	
}
