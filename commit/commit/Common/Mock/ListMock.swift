//
//  ListMock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/17.
//

import Foundation

class ListMock {
	static let section1 = SectionRealm(title: "家庭", sectionType: .normal)
	static let section2 = SectionRealm(title: "学校", sectionType: .normal)
	static let list = ListRealm(title: "General", sections: [section1, section2])
}
