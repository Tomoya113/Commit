//
//  RealmRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/29.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try
class RealmRepository<T: Object>: RealmRepositoryProtocol {
	
	var realm: Realm
	
	init() {
		realm = try! Realm()
	}
	
	func findByPrimaryKey(_ primaryKey: String) -> T? {
		return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
	}
	
	func findAll() -> [T] {
		return realm.objects(T.self).map { $0 }
	}
	
	func find(predicate: NSPredicate, completion: ((Result<[T], Never>) -> Void )?) {
		// 中身が空のときはErrorを投げたい
		let results = realm.objects(T.self).filter(predicate).map { $0 }
		completion?(.success(Array(results)))
	}
	
	func add(entities: [T]) {
		try! realm.write {
			realm.add(entities, update: .modified)
		}
	}
	
	func delete(entities: [T]) {
		try! realm.write {
			realm.delete(entities)
		}
	}
	
	func transaction(_ transactionBlock: () -> Void) {
		try! realm.write {
			transactionBlock()
		}
	}
}
