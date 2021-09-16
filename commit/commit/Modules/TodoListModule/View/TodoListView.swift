//
//  TodoListView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

struct TodoListView<Presenter>: View where Presenter: TodoListPresentation {
	@StateObject var presenter: Presenter
	@State private var showAlert: Bool = false
	@State private var isSheetPresented: Bool = false
	@State private var selectedSectionIndex: Int = 0
	
	var body: some View {
		ZStack {
			VStack {
				List {
					sections()
					SectionSpacer()
				}
				.listStyle(GroupedListStyle())
			}
			addButton {
				isSheetPresented.toggle()
			}
		}
		.navigationTitle("TODO")
		.onAppear {
			presenter.onAppear()
		}
		.fullScreenCover(
			isPresented: $isSheetPresented,
			onDismiss: {
				presenter.onDismiss()
			},
			content: {
				presenter.todoAddViewLinkBuilder()
			}
		)
		.alert(isPresented: $showAlert) {
			sectionDeleteConfirmationAlert {
				presenter.deleteSection(selectedSectionIndex)
			}
		}
	}
}

// UI周り
extension TodoListView {
	
	private func sections() -> some View {
		return (
			// NOTE: id無いとどれを削除したら良い変わらんってなってぴえんってなるやつ
			ForEach(presenter.displayData.sections.indices, id: \.self) { i in
				if !presenter.displayData.sections[i].isInvalidated {
					AnyView(
						todoSection(
							title: $presenter.displayData.sections[i].title,
							action: {
								showAlert = true
								selectedSectionIndex = 1
							},
							content: {
								todoList(presenter.displayData.sections[i].todos.map { $0 })
							}
						)
					)
				}
			}
			// NOTE: この方法でやるならdeBounceとか使う必要ありそう
//			ForEach(presenter.displayData.sections, id: \.self) { section in
//				if !section.isInvalidated {
//					AnyView(
//						todoSection(
//							title: .constant(section.title),
//							action: {
//								showAlert = true
//								selectedSectionIndex = 1
//						    },
//							content: {
//								todoList(section.todos.map { $0 })
//							})
//					)
//				}
//			}
		)
	}
	
	private func todoSection<Content: View>(title: Binding<String>, action: (() -> Void)?, @ViewBuilder content: () -> Content) -> some View {
		return (
			TodoSection(
				title: title,
				action: {
					action?()
				},
				content: {
					content()
				}
			)
		)
	}
	
	private func todoList(_ todos: [Todo]) -> some View {
		return (
			ForEach(todos) { todo in
				presenter.detailViewLinkBuilder(for: todo)
			}
		)
	}
	
	private func addButton(action: @escaping () -> Void) -> some View {
		return (
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						action()
					}, label: {
						TodoAddButton()
					})
					.padding()
				}
			}
		)
	}
}

#if DEBUG
// struct TodoListView_Previews: PreviewProvider {
//	 static var previews: some View {
//		 TodoListView(presenter: TodoListPresenter.sample)
//			 .environment(\.locale, Locale(identifier: "ja_JP"))
//	 }
// }
#endif
