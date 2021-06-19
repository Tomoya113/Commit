//
//  TodoListView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import SwiftUI

struct TodoListView: View {
	let list: ListRealm
	let todos: [[NormalTodo]]
	
	var body: some View {
		NavigationView {
			List {
				ForEach(list.sections.indices) { i in
					Section(header: Text(list.sections[i].title)) {
						ForEach(todos[i]) { todo in
							Text(todo.content!.title)
						}
					}
				}
			}
			.navigationTitle(list.title)
		}
	}
}

struct TodoListView_Previews: PreviewProvider {
	static var previews: some View {
		TodoListView(list: ListMock.list, todos: TodoMock.Alltodo)
	}
}
