//
//  TodoListView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

struct TodoListView: View {
	@ObservedObject var presenter: TodoListPresenter
	@State private var isActionSheetPresented: Bool = false
	@State private var showAlert: Bool = false
	@State private var selectedSectionIndex: Int = 0
	
	var body: some View {
		NavigationView {
			ZStack {
				VStack {
					List {
						if !presenter.lists.isEmpty {
							sections()
						}
					}
					.listStyle(GroupedListStyle())
				}
				addButton()
			}
			.alert(isPresented: $showAlert) {
				sectionDeleteConfirmationAlert()
			}
			// NOTE: こんな感じでout of rangeだったりするとエラーになる
			.navigationTitle(presenter.lists.isEmpty ? "" : presenter.lists[0].title)
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.onAppear {
			presenter.onAppear()
		}
	}
	
	private func sections() -> some View {
		return (
			// NOTE: id無いとどれを削除したら良い変わらんってなってぴえんってなるやつ
			ForEach(presenter.currentSections.indices, id: \.self) { i in
				if !presenter.currentSections[i].isInvalidated {
					if !presenter.currentSections[i].todos.isEmpty {
						Section(header: sectionHeader(title: presenter.currentSections[i].title, index: i)) {
							ForEach(presenter.currentSections[i].todos) { todo in
								presenter.detailViewLinkBuilder(for: todo) {
									presenter.generateTodoRow(
										todo: todo) {
										presenter.updateTodoStatus(todo: todo)
									}
								}
							}
						}
					} else {
						Section(header: sectionHeader(title: presenter.currentSections[i].title, index: i)) {
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
					if !presenter.lists.isEmpty {
						presenter.todoAddLinkBuidler(sections: presenter.currentSections) {
							presenter.addTodoButtonImage()
								.padding()
						}
					}
				}
			}
		)
	}
	
	private func sectionHeader(title: String, index: Int) -> some View {
		return (
			HStack {
				Text(title)
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

struct TodoListView_Previews: PreviewProvider {
	static var previews: some View {
		TodoListView(presenter: TodoListPresenter.sample)
			.environment(\.locale, Locale(identifier: "ja_JP"))
	}
}
