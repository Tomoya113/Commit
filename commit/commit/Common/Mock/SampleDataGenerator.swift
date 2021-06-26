//
//  SampleDataGenerator.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/25.
//

import Foundation
import RealmSwift

struct SampleDataGenerator {
	static func generateSampleData() {
		let realm = try! Realm()
		try! realm.write {
			 let section1 = SectionRealm(title: "家庭")
			 let section2 = SectionRealm(title: "学校")
			 let list1 = ListRealm(title: "General", sections: [section1, section2])
			 let todoA1 = Todo(
				sectionId: section1.id,
				title: "銀行に振り込み",
				detail: "2000円",
				displayTag: [DisplayTag(tagId: "1")],
				todoType: .normal
			)
			
			 let todoA2 =
				Todo(
					sectionId: section1.id,
					title: "課題終わらせる",
					detail: "1時間程度",
					displayTag: [DisplayTag(tagId: "2")],
					todoType: .normal
				)
			
			 let todoA3 = Todo(
				sectionId: section1.id,
				title: "部屋の掃除する",
				detail: "1時間程度",
				displayTag: [DisplayTag(tagId: "3")],
				todoType: .normal
			)
			
			 let todoB1 = Todo(
				sectionId: section2.id,
				title: "銀行に振り込み",
				detail: "2000円",
				displayTag: [DisplayTag(tagId: "1")],
				todoType: .normal
			)
			
			 let todoB2 = Todo(
				sectionId: section2.id,
				title: "課題終わらせる",
				detail: "1時間程度",
				displayTag: [DisplayTag(tagId: "2")],
				todoType: .normal
			)
			
			 let todoB3 = Todo(
				sectionId: section2.id,
				title: "部屋の掃除する",
				detail: "1時間程度",
				displayTag: [DisplayTag(tagId: "3")],
				todoType: .normal
			)
			realm.add(list1)
			realm.add(section1)
			realm.add(section2)
			realm.add(todoA1)
			realm.add(todoA2)
			realm.add(todoA3)
			realm.add(todoB1)
			realm.add(todoB2)
			realm.add(todoB3)
		}
	}
}
