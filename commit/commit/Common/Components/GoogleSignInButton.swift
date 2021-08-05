//
//  GoogleSignInButton.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/04.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresentable {
	func makeUIView(context: Context) -> GIDSignInButton {
		let button = GIDSignInButton()
		button.style = .standard
		return button
	}

	func updateUIView(_ uiView: GIDSignInButton, context: Context) {
		
	}
}

struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton()
    }
}
