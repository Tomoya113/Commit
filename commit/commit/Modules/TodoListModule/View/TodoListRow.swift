//
//  TodoListRow.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/20.
//

import SwiftUI

struct TodoListRow: View {
	let todo: Todo
	@State var finished: Bool
    var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 8) {
				if finished {
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
				finished = !finished
			}, label: {
				if finished {
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
    static var previews: some View {
		TodoListRow(
			todo: TodoMock.todoA1.content!,
			finished: TodoMock.todoA1.content!.status!.finished)
			.padding()
    }
}
