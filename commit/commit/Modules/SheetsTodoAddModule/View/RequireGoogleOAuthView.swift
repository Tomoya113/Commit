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
		GeometryReader { geometry in
			HStack(alignment: .center) {
				VStack {
					Spacer()
					Text("Googleスプレッドシートと連携するにはアプリとGoogleアカウントの連携が必要です。")
//						.bold()
						.multilineTextAlignment(.center)
						
					HStack(alignment: .center) {
						GoogleSignInButton()
							.frame(width: 230, height: 48)
					}
					Spacer()
				}
				.frame(width: geometry.size.width - 32)
			}
			.frame(width: geometry.size.width)
		}
	}
}

struct RequireGoogleOAuthView_Previews: PreviewProvider {
	static var previews: some View {
		RequireGoogleOAuthView {
			print("hoge")
		}
	}
}
