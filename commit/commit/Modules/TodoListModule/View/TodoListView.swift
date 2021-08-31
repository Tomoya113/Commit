//
//  TodoListView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

struct TodoListView: View {
	@StateObject var presenter: TodoListPresenter
	@State private var showAlert: Bool = false
	@State private var isSheetPresented: Bool = false
	@State private var selectedSectionIndex: Int = 0
	
	var body: some View {
		ZStack {
			VStack {
				List {
					if presenter.displayData.defaultSection != nil {
						todoList(presenter.displayData.defaultSection!.todos.map { $0 })
					}
					sections()
					SectionSpacer()
				}
				.listStyle(GroupedListStyle())
			}
			addButton()
		}
		.navigationTitle("TODO")
		.onAppear {
			presenter.onAppear()
		}
		.sheet(
			isPresented: $isSheetPresented,
			onDismiss: {
				
			},
			content: {
				presenter.todoAddLinkBuilder()
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
			ForEach(presenter.displayData.currentSections.indices, id: \.self) { i in
				if !presenter.displayData.currentSections[i].isInvalidated {
					todoSection(i) {
						todoList(presenter.displayData.currentSections[i].todos.map { $0 })
					}
				} else {
					todoSection(i) {
						EmptySectionView()
					}
				}
			}
		)
	}
	
	private func todoSection<Content: View>(_ index: Int, @ViewBuilder content: () -> Content) -> some View {
		return (
			TodoSection(
				title: $presenter.displayData.currentSections[index].title,
				action: {
					showAlert = true
					selectedSectionIndex = index
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
				presenter.detailViewLinkBuilder(for: todo) {
					presenter.generateTodoRow(
						todo: todo) {
						presenter.updateTodoStatus(todo: todo)
					}
				}
			}
		)
	}
	
	private func addButton() -> some View {
		return (
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						isSheetPresented.toggle()
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
struct TodoListView_Previews: PreviewProvider {
	static var previews: some View {
		TodoListView(presenter: TodoListPresenter.sample)
			.environment(\.locale, Locale(identifier: "ja_JP"))
	}
}
#endif
