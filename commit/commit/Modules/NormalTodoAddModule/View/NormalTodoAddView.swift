//
//  NormalTodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import SwiftUI

struct NormalTodoAddView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@ObservedObject var presenter: NormalTodoAddPresenter
	@Binding var sections: [SectionRealm]
    var body: some View {
		Form {
			Section(header: Text("タスク名")) {
				TextField("タスク名", text: $presenter.title)
			}
			Section(header: Text("説明")) {
				TextField("タスクの説明", text: $presenter.subtitle)
			}
			Picker(selection: $presenter.currentSectionId, label: Text("セクション")) {
				ForEach(sections, id: \.id) { section in
					Text(section.title)
				}
			}
		}
		SubmitButton {
			didTapSubmitButton()
		}
    }
	
	private func didTapSubmitButton() {
		presentationMode.wrappedValue.dismiss()
		presenter.createNewTodo()
	}
}

struct NormalTodoAddView_Previews: PreviewProvider {
	@State static var sections: [SectionRealm] = []
    static var previews: some View {
		NormalTodoAddView(presenter: NormalTodoAddPresenter.sample, sections: $sections)
    }
}
