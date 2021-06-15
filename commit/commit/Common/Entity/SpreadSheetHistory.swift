//
//  SpreadSheetHistory.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/16.
//

import RealmSwift

class SpreadSheetHistory: Object {
	@objc dynamic var spreadSheetId: String = ""
	@objc dynamic var title: String = ""
}
