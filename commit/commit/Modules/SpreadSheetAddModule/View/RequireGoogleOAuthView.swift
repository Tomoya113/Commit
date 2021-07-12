//
//  RequireGoogleOAuthView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/12.
//

import SwiftUI

struct RequireGoogleOAuthView: View {
	var action: () -> Void
    var body: some View {
		VStack {
			Spacer()
			Button(action: {
				action()
			}, label: {
				Text("SignIn")
			})
			Spacer()
		}
		.contentShape(Rectangle())
		
    }
}

struct RequireGoogleOAuthView_Previews: PreviewProvider {
    static var previews: some View {
		RequireGoogleOAuthView {
			print("hoge")
		}
    }
}
