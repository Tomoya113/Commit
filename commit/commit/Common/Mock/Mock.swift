//
//  Mock.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import Foundation

class Mock {

	struct List {
		let title: String
		let sections: [Section]
	}
	
	struct Section {
		let title: String
		let type: Self.SectionType
		enum SectionType: String {
			case normal
			case googleSheets
			case undefined
		}
	}
	
	struct Todo {
		let sectionId: String
		let title: String
		let status: TodoStatus
		let tags: [DisplayTag]
	}
	
	struct DisplayTag {
		let tagId: String
	}

	struct TodoStatus {
		let finished: Bool
		let detail: String
	}
}
