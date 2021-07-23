//
//  WebView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
	var loadURL: String

	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}

	func updateUIView(_ uiView: WKWebView, context: Context) {
		uiView.load(URLRequest(url: URL(string: loadURL)!))
	}
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(loadURL: "https://www.apple.com")
    }
}
