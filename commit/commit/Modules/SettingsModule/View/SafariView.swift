//
//  SafariView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/28.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
	let url: URL
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
		 return SFSafariViewController(url: url)
	 }

	 func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

	 }
}
