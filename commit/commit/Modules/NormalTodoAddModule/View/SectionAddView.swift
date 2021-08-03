//
//  SectionAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/03.
//

import SwiftUI

struct SectionAddView: View {
	@Environment(\.presentationMode) var presentationMode
	@Binding var sectionTitle: String
	var action: () -> Void
    var body: some View {
		Form {
			TextField("セクション名", text: $sectionTitle)
			Button(action: {
				action()
				presentationMode.wrappedValue.dismiss()
			}, label: {
				Text("追加")
			})
		}
		.navigationTitle("セクションを追加")
    }
}

struct SectionAddView_Previews: PreviewProvider {
	@State static var sectionTitle = ""
    static var previews: some View {
		SectionAddView(sectionTitle: $sectionTitle) {
			print("hoge")
		}
    }
}
