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
	@State private var selectedSectionIndex: Int = 0
	
	var body: some View {
		NavigationView {
			ZStack {
				VStack {
					List {
						if presenter.displayData.defaultSection != nil {
							if !presenter.displayData.defaultSection!.todos.isEmpty {
								Section(header: Text(presenter.displayData.defaultSection!.title)) {
									ForEach(presenter.displayData.defaultSection!.todos) { todo in
										presenter.detailViewLinkBuilder(for: todo) {
											presenter.generateTodoRow(
												todo: todo) {
												updateTodoStatus(todo)
											}
										}
									}
								}
							} else {
								Section(header: Text(presenter.displayData.defaultSection!.title)) {
									HStack(alignment: .center) {
										Spacer()
										Text("タスクがありません！")
										Spacer()
									}
								}
							}
						}
						if !presenter.displayData.lists.isEmpty {
							sections()
							// NOTE: 下に空白作るためのやつ(もっとほかのいいやり方ありそう)
							Section {
								
							}
							Section {
								
							}
						}
					}
					.listStyle(GroupedListStyle())
					
				}
				addButton()
			}
			.alert(isPresented: $showAlert) {
				sectionDeleteConfirmationAlert()
			}
			.navigationTitle("TODO")
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.onAppear {
			presenter.onAppear()
		}
	}
	
	private func updateTodoStatus(_ todo: Todo) {
		presenter.updateTodoStatus(todo: todo)
	}
	
	private func sections() -> some View {
		return (
			// NOTE: id無いとどれを削除したら良い変わらんってなってぴえんってなるやつ
			ForEach(presenter.displayData.currentSections.indices, id: \.self) { i in
				if !presenter.displayData.currentSections[i].isInvalidated {
					if !presenter.displayData.currentSections[i].todos.isEmpty {
						Section(header: sectionHeader(index: i)) {
							ForEach(presenter.displayData.currentSections[i].todos) { todo in
								presenter.detailViewLinkBuilder(for: todo) {
									presenter.generateTodoRow(
										todo: todo) {
										presenter.updateTodoStatus(todo: todo)
									}
								}
							}
						}
					} else {
						Section(header: sectionHeader(index: i)) {
							HStack(alignment: .center) {
								Spacer()
								Text("タスクがありません！")
								Spacer()
							}
						}
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
					if !presenter.displayData.lists.isEmpty {
						presenter.todoAddLinkBuilder(sections: presenter.displayData.currentSections) {
							presenter.addTodoButtonImage()
								.padding()
						}
					}
				}
			}
		)
	}
	
	private func sectionHeader(index: Int) -> some View {
		return (
			HStack {
				TextField($presenter.displayData.currentSections[index].title.wrappedValue, text: $presenter.displayData.currentSections[index].title)
					.foregroundColor(Color.blue)
				Spacer()
				Button(action: {
					showAlert = true
					selectedSectionIndex = index
				}, label: {
					Image(systemName: "trash")
				})
			}
		)
	}
	
	private func sectionDeleteConfirmationAlert() -> Alert {
		Alert(
			title: Text("セクションの削除"),
			message: Text("セクションを削除しますか？"),
			primaryButton: .cancel(
				Text("キャンセル"),
				action: {
					print("cancel")
				}
			),
			secondaryButton: .destructive(
				Text("削除"),
				action: {
					presenter.deleteSection(selectedSectionIndex)
				}
			)
		)
	}
	
}

extension TodoListView {
	func padding() -> EdgeInsets {
		EdgeInsets(
			top: 0,
			leading: 0,
			bottom: 0,
			trailing: 24
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
