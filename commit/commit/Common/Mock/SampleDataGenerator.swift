//
//  SampleDataGenerator.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/25.
//

import Foundation
import RealmSwift

struct SampleDataGenerator {
	static func initializeSampleData() {
//		let realm = try! Realm()
//		print("Realm is located at:", realm.configuration.fileURL!)
//		try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
		SampleDataGenerator.generateSampleData()
	}
	
	static func generateSampleData() {
		let realm = try! Realm()
		try! realm.write {
			let todoA1 = Todo(
				title: "銀行に振り込み",
				detail: "2000円",
				displayTag: [DisplayTag(tagId: "1")],
				todoType: .normal
			)
			
			let todoA2 =
				Todo(
					title: "課題終わらせる",
					detail: "1時間程度",
					displayTag: [DisplayTag(tagId: "2")],
					todoType: .normal
				)
			
			let todoA3 = Todo(
				title: "部屋の掃除する",
				detail: "1時間程度",
				displayTag: [DisplayTag(tagId: "3")],
				todoType: .normal
			)
			
			let todoB1 = Todo(
				title: "銀行に振り込み",
				detail: "2000円",
				displayTag: [DisplayTag(tagId: "1")],
				todoType: .normal
			)
			
			let todoB2 = Todo(
				title: "課題終わらせる",
				detail: "1時間程度",
				displayTag: [DisplayTag(tagId: "2")],
				todoType: .normal
			)
			
			let todoB3 = Todo(
				title: "部屋の掃除する",
				detail: "1時間程度",
				displayTag: [DisplayTag(tagId: "3")],
				todoType: .normal
			)
			let section1 = SectionRealm(title: "家庭", todos: [todoA1, todoA2, todoA3])
			let section2 = SectionRealm(title: "学校", todos: [todoB1, todoB2, todoB3])
			let list1 = ListRealm(title: "General", sections: [section1, section2])
			
			realm.add(list1)
			
		}
	}
}
