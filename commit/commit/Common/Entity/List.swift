//
//  List.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class List: Object {
	@objc dynamic var title: String = ""
	let sections = RealmSwift.List<Section>()
}

class Section: Object {
	@objc dynamic var title: String = ""
	@objc dynamic var typeRawValue: String = SectionType.undefined.rawValue
	
	var type: SectionType {
			get { return SectionType(rawValue: typeRawValue) ?? .undefined }
			set { typeRawValue = newValue.rawValue }
		}
}

enum SectionType: String {
	case normal
	case googleSheets
	case undefined
}
