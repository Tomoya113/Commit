//
//  TodoMock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import Foundation

class TodoMock {
	static let todoA1 = Todo(
		title: "銀行に振り込み",
		detail: "2000円",
		displayTag: [DisplayTag(tagId: "1")],
		todoType: .normal
	)
	
	static let todoA2 =
		Todo(
			title: "課題終わらせる",
			detail: "1時間程度",
			displayTag: [DisplayTag(tagId: "2")],
			todoType: .normal
		)
	
	static let todoA3 = Todo(
		title: "部屋の掃除する",
		detail: "1時間程度",
		displayTag: [DisplayTag(tagId: "3")],
		todoType: .normal
	)
	
	static let todoB1 = Todo(
		title: "銀行に振り込み",
		detail: "2000円",
		displayTag: [DisplayTag(tagId: "1")],
		todoType: .normal
	)
	
	static let todoB2 = Todo(
		title: "課題終わらせる",
		detail: "1時間程度",
		displayTag: [DisplayTag(tagId: "2")],
		todoType: .normal
	)
	
	static let todoB3 = Todo(
		title: "部屋の掃除する",
		detail: "1時間程度",
		displayTag: [DisplayTag(tagId: "3")],
		todoType: .normal
	)
	
	static let todosA = [
		todoA1,
		todoA2,
		todoA3
	]
	
	static let todosB = [
		todoB1,
		todoB2,
		todoB3
	]
	
	static let allTodo = [
		todosA,
		todosB
	]
}
