//
//  Button.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import SwiftUI

struct SubmitButton: View {
	var title: String
	var action: () -> Void
    var body: some View {
		Button(action: {
			action()
		}, label: {
			Text(title)
				.fontWeight(.bold)
				.frame(minWidth: 0, maxWidth: .infinity)
				.font(.system(size: 18))
				.padding()
				.foregroundColor(.white)
				.background(Color.green)
				.cornerRadius(10)
		})
		.padding(
			EdgeInsets(
				top: -8,
				leading: 12,
				bottom: 0,
				trailing: 12)
		)
    }
}

struct SubmitButton_Previews: PreviewProvider {
	static func test() {}
	
    static var previews: some View {
		SubmitButton(title: "hoge") {
			test()
		}
    }
}
