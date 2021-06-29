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
	var body: some View {
		NavigationView {
			ZStack {
				List {
					if presenter.currentList != nil {
						ForEach(presenter.currentList!.sections) { section in
							Section(header: Text(section.title)) {
								ForEach(section.todos) { todo in
									presenter.linkBuilder(for: todo) {
										presenter.generateTodoRow(
											todo: todo,
											updateTodoStatus: presenter.updateTodoStatus
										)
									}
								}
							}
						}
					}
				}.listStyle(InsetGroupedListStyle())
				VStack {
					Spacer()
					HStack {
						Spacer()
						Button(action: {
							isActionSheetPresented = true
						}, label: {
							presenter.addTodoButtonImage()
						})
						.padding(padding())
						.actionSheet(isPresented: $isActionSheetPresented, content: {
							presenter.actionSheet()
						})
					}
				}
			}
			// NOTE: こんな感じでout of rangeだったりするとエラーになる
			.navigationTitle(presenter.currentList?.title ?? "")
		}.onAppear {
			presenter.onAppear()
		}
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
	static var sample = TodoListPresenter.sample
	static var previews: some View {
		TodoListView(presenter: TodoListPresenter.sample)
			.environment(\.locale, Locale(identifier: "ja_JP"))
	}
}
