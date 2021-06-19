//
//  TodoMock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import Foundation

class TodoMock {
	static let todoA1 = NormalTodo(
		todo: Todo(
			sectionId: "1",
			title: "銀行に振り込み",
			detail: "2000円",
			displayTag: [DisplayTag(tagId: "1")]
		)
	)
	
	static let todoA2 = NormalTodo(
		todo: Todo(
			sectionId: "1",
			title: "課題終わらせる",
			detail: "1時間程度",
			displayTag: [DisplayTag(tagId: "2")]
		)
	)
	
	static let todoA3 = NormalTodo(
		todo: Todo(
			sectionId: "1",
			title: "部屋の掃除する",
			detail: "1時間程度",
			displayTag: [DisplayTag(tagId: "3")]
		)
	)
	
	static let todoB1 = NormalTodo(
		todo: Todo(
			sectionId: "2",
			title: "銀行に振り込み",
			detail: "2000円",
			displayTag: [DisplayTag(tagId: "1")]
		)
	)
	
	static let todoB2 = NormalTodo(
		todo: Todo(
			sectionId: "2",
			title: "課題終わらせる",
			detail: "1時間程度",
			displayTag: [DisplayTag(tagId: "2")]
		)
	)
	
	static let todoB3 = NormalTodo(
		todo: Todo(
			sectionId: "2",
			title: "部屋の掃除する",
			detail: "1時間程度",
			displayTag: [DisplayTag(tagId: "3")]
		)
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
	
	static let Alltodo = [
		todosA,
		todosB
	]
}
