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
	let updateTodoStatus: () -> Void
	var body: some View {
		HStack(alignment: .center) {
			if !todo.isInvalidated {
				VStack(alignment: .leading, spacing: 8) {
					title()
					if todo.subtitle != "" {
						subtitle()
					}
				}
				Spacer()
				checkButton()
			}
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
	
	private func checkButton() -> some View {
		return (
			Button(action: {
				UIFeedbackManager.shared.lightImpact()
				updateTodoStatus()
			}, label: {
				// NOTE: 個々の書き方嫌い
				if todo.status!.detail != "" {
					if todo.status!.finished {
						Text(todo.status!.detail)
						.strikethrough()
						.minimumScaleFactor(0.5)
						.lineLimit(1)
						.foregroundColor(.gray)
					} else {
						Text(todo.status!.detail)
						.minimumScaleFactor(0.5)
						.lineLimit(1)
						.foregroundColor(.gray)
					}
					
				} else {
					Text(
						Image(
							systemName: todo.status!.finished ? "checkmark.square" : "circle"
						)
					)
					.font(.system(size: 30))
					.foregroundColor(.gray)
				}
				
			})
			.buttonStyle(PlainButtonStyle())
		)
		
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
