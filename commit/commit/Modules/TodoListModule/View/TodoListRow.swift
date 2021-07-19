//
//  TodoListRow.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/20.
//

import SwiftUI
import RealmSwift

struct TodoListRow: View {
	var todo: Todo
	let updateTodoStatus: () -> Void
	var body: some View {
		HStack(alignment: .center) {
			VStack(alignment: .leading, spacing: 8) {
				title()
				if todo.subtitle != "" {
					subtitle()
				}
			}
			Spacer()
			Button(action: {
				updateTodoStatus()
			}, label: {
				Text(
					Image(
						systemName: todo.status!.finished ? "checkmark.square" : "circle"
					)
				)
				.font(.system(size: 30))
				.foregroundColor(.gray)
			})
			.buttonStyle(PlainButtonStyle())
		}
	}
	
	private func title() -> some View {
		if todo.status!.finished {
			return (
				Text(todo.title)
					.strikethrough()
					.foregroundColor(.gray)
			)
		} else {
			return Text(todo.title)
		}
	}
	
	private func subtitle() -> some View {
		if todo.status!.finished {
			return (
				Text(todo.subtitle)
					.strikethrough()
					.font(.subheadline).foregroundColor(.gray)
			)
		} else {
			return (
				Text(todo.subtitle)
					.font(.subheadline).foregroundColor(.gray)
			)
		}
	}
}

struct TodoListRow_Previews: PreviewProvider {
	static func test(todo: Todo) {
		print(todo)
	}
	static var previews: some View {
		VStack {
			TodoListRow(todo: TodoMock.todoA1) {
				test(todo: TodoMock.todoA1)
			}
				.padding()
			TodoListRow(todo: TodoMock.todoWithoutDetail) {
				test(todo: TodoMock.todoA1)
			}
				.padding()
		}
	}
}
