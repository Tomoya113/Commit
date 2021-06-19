//
//  List.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class ListRealm: Object, ObjectKeyIdentifiable {
	@objc dynamic var title: String = ""
	let sections = List<SectionRealm>()
	
	convenience init(title: String, sections: [SectionRealm]) {
		self.init()
		self.title = title
		self.sections.append(objectsIn: sections)
	}
	
}

class SectionRealm: Object, ObjectKeyIdentifiable {
	@objc dynamic var title: String = ""
	@objc dynamic var typeRawValue: String = SectionType.undefined.rawValue
	
	var type: SectionType {
			get { return SectionType(rawValue: typeRawValue) ?? .undefined }
			set { typeRawValue = newValue.rawValue }
	}
	
	convenience init(title: String, sectionType: SectionType) {
		self.init()
		self.title = title
		self.type = sectionType
	}
}

enum SectionType: String {
	case normal
	case googleSheets
	case undefined
}
