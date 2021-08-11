//
//  DataEraser.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/10.
//

import Foundation
import RealmSwift

class DataEraser {
	static func execute() {
		try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
		let appDomain = Bundle.main.bundleIdentifier
		UserDefaults.standard.removePersistentDomain(forName: appDomain!)
	}
}
