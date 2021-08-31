//
//  NormalTodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import SwiftUI

struct NormalTodoAddView: View {
	@StateObject var presenter: NormalTodoAddPresenter
	@EnvironmentObject var presentationObject: PresentationObject
    var body: some View {
		Form {
			Section(header: Text("タスク名")) {
				TextField("タスク名", text: $presenter.title)
			}
			Section(header: Text("説明")) {
				TextField("タスクの説明", text: $presenter.subtitle)
			}
			
			Section(header: Text("セクション")) {
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
			
			Button(action: {
				presentationObject.presentationMode.wrappedValue.dismiss()
				didTapSubmitButton()
			}, label: {
				Text("追加")
					.multilineTextAlignment(.center)
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
			})
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
		presenter.createNewTodo()
	}
}

#if DEBUG
struct NormalTodoAddView_Previews: PreviewProvider {
	@State static var sections: [SectionRealm] = []
    static var previews: some View {
		NavigationView {
			NormalTodoAddView(presenter: NormalTodoAddPresenter.sample)
		}
    }
}
#endif
