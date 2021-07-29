//
//  RealmRepositoryProtocol.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/29.
//

import Foundation
import RealmSwift

protocol RealmRepositoryProtocol {
	associatedtype EntityType: Object
	// Primary keyで検索
	func findByPrimaryKey(_ primaryKey: String) -> EntityType?
	
	// Entity全部取得
	func findAll() -> [EntityType]
	
	// 条件に一致したデータを取得する
	func find(predicate: NSPredicate) -> Results<EntityType>
	
	// データ追加&更新
	func add(entities: [EntityType])
	
	// データ削除
	func delete(entities: [EntityType])
	
	// トランザクション
	func transaction(_ transactionBlock: () -> Void)
	
}
