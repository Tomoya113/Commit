//
//  ListMock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/17.
//

import Foundation

class ListMock {
	static let section1 = SectionRealm(title: "家庭")
	static let list1 = ListRealm(title: "General", sections: [section1])
	static let lists = [
		list1
	]
}
