//
//  NormalTodoForm.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/06.
//

import SwiftUI

struct NormalTodoForm: View {
	@Binding var title: String
	@Binding var subtitle: String
	var sections: [SectionRealm]
	@Binding var currentSectionId: String
    var body: some View {
		Form {
			Section(header: Text("タスク名")) {
				TextField("タスク名", text: $title)
			}
			Section(header: Text("説明")) {
				TextField("タスクの説明", text: $subtitle)
			}
			Picker(selection: $currentSectionId, label: Text("セクション")) {
				ForEach(sections, id: \.id) { section in
					Text(section.title)
				}
			}
		}
    }
}

struct NormalTodoForm_Previews: PreviewProvider {
	@State static var title = ""
	@State static var subtitle = ""
	@State static var currentSectionId = ""
	@State static var sections = ListMock.list1.sections
    static var previews: some View {
        NormalTodoForm(
			title: $title,
			subtitle: $subtitle,
			sections: Array(sections),
			currentSectionId: $currentSectionId
		)
    }
}
