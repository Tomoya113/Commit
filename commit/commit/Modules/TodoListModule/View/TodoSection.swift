//
//  TodoSection.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/30.
//

import SwiftUI

struct TodoSection<Content: View>: View {
	@Binding var title: String
	var action: () -> Void
	let content: Content
	
	init(
		title: Binding<String>, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
		self._title = title
		self.action = action
		self.content = content()
	}
	
	var body: some View {
		Section(header: SectionHeader(sectionTitle: $title) {
			action()
		}) {
			content
		}
	}
}

struct TodoSection_Previews: PreviewProvider {
	@State static var test = "test"
	static var previews: some View {
		TodoSection(
			title: $test,
			action: {
				print("hoge")
			}, content: {
				Text("aaa")
			})
	}
}
