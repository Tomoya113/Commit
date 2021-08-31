//
//  SectionHeader.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/30.
//

import SwiftUI

struct SectionHeader: View {
	@Binding var sectionTitle: String
	var action: () -> Void
    var body: some View {
		HStack {
			TextField($sectionTitle.wrappedValue, text: $sectionTitle)
				.foregroundColor(Color.blue)
			Spacer()
			Button(action: {
				action()
			}, label: {
				Image(systemName: "trash")
			})
		}
    }
}

struct SectionHeader_Previews: PreviewProvider {
	@State static var title = ""
    static var previews: some View {
		SectionHeader(sectionTitle: $title) {
			print("sectionHeader")
		}
    }
}
