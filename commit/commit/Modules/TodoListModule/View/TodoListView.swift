//
//  TodoListView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

struct TodoListView: View {
	@ObservedObject var presenter: TodoListPresenter
	var body: some View {
		ZStack {
			NavigationView {
				List {
					//　初回に空の配列を渡すと、高さが確保されずに後の更新でも表示がうまくされなくなってしまうので、中身が生成された時点で初めてレンダーするように制御
					if !presenter.currentSection.isEmpty && !presenter.todos.isEmpty {
						ForEach(presenter.currentSection.indices) { i in
							Section(header: Text(presenter.currentSection[i].title)) {
								ForEach(presenter.todos[i]) { todo in
									TodoListRow(todo: todo, updateTodoStatus: presenter.updateTodoStatus)
								}
							}
						}
					}
				}
// NOTE: こんな感じでout of rangeだったりするとエラーになる
				.navigationTitle(presenter.currentList?.title ?? "")
			}
			.onAppear {
				presenter.onAppear()
			}
		}

	}
}

struct TodoListView_Previews: PreviewProvider {
	static var sample = TodoListPresenter.sample
	static var previews: some View {
		TodoListView(presenter: TodoListPresenter.sample)
			.environment(\.locale, Locale(identifier: "ja_JP"))
	}
}
