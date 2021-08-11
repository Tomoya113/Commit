//
//  WebView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
	var url: URL

	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}

	func updateUIView(_ uiView: WKWebView, context: Context) {
		uiView.load(URLRequest(url: url))
	}
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
		WebView(url: URL(string: "https://www.apple.com")!)
    }
}
