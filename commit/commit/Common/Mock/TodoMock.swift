//
//  TodoMock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import Foundation

class TodoMock {
	static let todoA1 = Mock.Todo(
		sectionId: "1",
		title: "銀行に振り込み",
		status: Mock.TodoStatus(finished: false, detail: "2000円"),
		tags: [Mock.DisplayTag(tagId: "1")]
	)
	static let todoA2 = Mock.Todo(
		sectionId: "1",
		title: "課題を終わらせる",
		status: Mock.TodoStatus(finished: false, detail: "1時間程度を想定"),
		tags: [Mock.DisplayTag(tagId: "2")]
	)
	static let todoA3 = Mock.Todo(
		sectionId: "1",
		title: "部屋の掃除する",
		status: Mock.TodoStatus(finished: false, detail: "空気清浄機を掃除"),
		tags: [Mock.DisplayTag(tagId: "3")]
	)
	
	static let todoB1 = Mock.Todo(
		sectionId: "1",
		title: "銀行に振り込み",
		status: Mock.TodoStatus(finished: false, detail: "2000円"),
		tags: [Mock.DisplayTag(tagId: "1")]
	)
	static let todoB2 = Mock.Todo(
		sectionId: "1",
		title: "課題を終わらせる",
		status: Mock.TodoStatus(finished: false, detail: "1時間程度を想定"),
		tags: [Mock.DisplayTag(tagId: "2")]
	)
	static let todoB3 = Mock.Todo(
		sectionId: "1",
		title: "部屋の掃除する",
		status: Mock.TodoStatus(finished: false, detail: "空気清浄機を掃除"),
		tags: [Mock.DisplayTag(tagId: "3")]
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
