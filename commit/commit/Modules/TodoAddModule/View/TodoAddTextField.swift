//
//  TodoAddTextField.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/01.
//

import SwiftUI

struct TodoAddTextField: View {
	@Binding var text: String
	var placeholder: String
	var header: String
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(header).font(.headline)
			TextField(placeholder, text: $text)
				.padding(.all)
				.clipShape(RoundedRectangle(cornerRadius: 5.0))
				.background(Color(
								red: 239.0 / 255.0,
								green: 243.0 / 255,
								blue: 244.0 / 255.0,
								opacity: 1.0)
				)
		}
	}
	
}

struct TodoAddTextField_Previews: PreviewProvider {
	@State static var text: String = ""
	static var previews: some View {
		TodoAddTextField(text: $text, placeholder: "placeholder", header: "タスク名")
	}
}
