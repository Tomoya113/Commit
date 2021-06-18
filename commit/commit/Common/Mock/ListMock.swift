//
//  ListMock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/17.
//

import Foundation

class ListMock {
	static let section1 = Mock.Section(title: "家", type: .normal)
	static let section2 = Mock.Section(title: "学校", type: .normal)
	static let list = Mock.List(title: "General", sections: [section1, section2])
}
