//
//  NormalTodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import SwiftUI

struct NormalTodoAddView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@StateObject var presenter: NormalTodoAddPresenter
    var body: some View {
		Form {
			Section(header: Text("タスク名")) {
				TextField("タスク名", text: $presenter.title)
			}
			Section(header: Text("説明")) {
				TextField("タスクの説明", text: $presenter.subtitle)
			}
			Picker(selection: $presenter.selectedSectionId, label: Text("セクション")) {
				ForEach(presenter.sections, id: \.id) { section in
					Text(section.title)
				}
				NavigationLink(
					destination: SectionAddView(
						sectionTitle: $presenter.sectionTitle,
						action: {
							presenter.isActive = false
							presenter.addSection(title: presenter.sectionTitle)
						}
					),
					isActive: $presenter.isActive,
					label: {
						sectionAddButton()
					}
				)
				.onAppear {
					presenter.fetchAllSections()
				}
			}
		}
		SubmitButton(title: "追加") {
			didTapSubmitButton()
		}
    }
	
	private func sectionAddButton() -> some View {
		return (
			Button(action: {
				presenter.isActive.toggle()
			}, label: {
				GeometryReader { geometry in
					Text("追加する")
						.frame(
							width: geometry.size.width + 200,
							height: 30,
							alignment: .leading
						)
				}
			})
		)
	}
	
	private func didTapSubmitButton() {
		presentationMode.wrappedValue.dismiss()
		presenter.createNewTodo()
	}
}

struct NormalTodoAddView_Previews: PreviewProvider {
	@State static var sections: [SectionRealm] = []
    static var previews: some View {
		NavigationView {
			NormalTodoAddView(presenter: NormalTodoAddPresenter.sample)
		}
    }
}
