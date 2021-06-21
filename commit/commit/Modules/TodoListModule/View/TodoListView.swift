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
//					ForEach(presenter.currentSection.indices) { i in
//						Section(header: Text(presenter.currentSection[i].title)) {
//							ForEach(presenter.todos)
//						}
//					}
//					ForEach(presenter.currentSection, id: \.id) { section in
//						Section(header: Text(section.title)) {
//							ForEach(presenter.todos[i]) { todo in
//								TodoListRow(todo: todo.content!, finished: todo.content!.status!.finished)
//							}
//						}
//					}
				}
				.navigationTitle(presenter.lists[0].title)
			}
		}
		
	}
}

//struct TodoListView_Previews: PreviewProvider {
//	let dependency = de
//	let presenter = TodoListPresenter(dependency: <#T##TodoListPresenter.Dependency#>)
//	static var previews: some View {
//		TodoListView(list: ListMock.list, todos: TodoMock.Alltodo)
//			.environment(\.locale, Locale(identifier: "ja_JP"))
//	}
//}
