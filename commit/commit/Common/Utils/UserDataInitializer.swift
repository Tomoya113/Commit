//
//  UserDataInitializer.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/06.
//

import Foundation
import RealmSwift

class UserDataInitializer {
	static func generateInitialUserData() {
		// swiftlint:disable force_try
		let realm = try! Realm()
		let todo = Todo(
			title: "サンプル",
			detail: "サンプルのTODOです",
			displayTag: [],
			todoType: .normal)
		let section = SectionRealm(title: "未分類", todos: [todo])
		let list = ListRealm(title: "General", sections: [section])
		try! realm.write {
			section.id = "1"
			realm.add(list)
		}
	}

}
