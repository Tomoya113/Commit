//
//  TodoListRow.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/20.
//

import SwiftUI
import RealmSwift

struct TodoListRow: View {
	@ObservedRealmObject var todo: Todo
	let updateTodoStatus: ((String) -> Void)
    var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 8) {
				if todo.status!.finished {
					Text(todo.title)
						.strikethrough()
						.foregroundColor(.gray)
					Text(todo.status!.detail)
						.strikethrough()
						.font(.subheadline).foregroundColor(.gray)
				} else {
					Text(todo.title)
					Text(todo.status!.detail)
						.font(.subheadline).foregroundColor(.gray)
				}
			}
			Spacer()
			Button(action: {
				updateTodoStatus(todo.id)
			}, label: {
				if todo.status!.finished {
					Text(Image(systemName: "checkmark.square"))
						.font(.system(size: 30))
						.foregroundColor(.gray)
				} else {
					Text(Image(systemName: "circle"))
						.font(.system(size: 30))
						.foregroundColor(.gray)
				}
			})
			.buttonStyle(PlainButtonStyle())
		}
    }
}

struct TodoListRow_Previews: PreviewProvider {
	static func test(id: String) {
		print(id)
	}
    static var previews: some View {
		TodoListRow(todo: TodoMock.todoA1, updateTodoStatus: test)
			.padding()
    }
}
