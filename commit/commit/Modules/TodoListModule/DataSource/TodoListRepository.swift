//
//  TodoListRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation
import RealmSwift

class TodoListRepository: Repository {
	let realm = try! Realm()
	private var notificationTokens: [NotificationToken] = []
	
	func findTodosById(_ id: String, completion: ((Result<[Todo], Never>) -> Void)?) {
		let todos = realm.objects(Todo.self).filter("sectionId == %@", id)
		notificationTokens.append(todos.observe { change in
			switch change {
			case let .initial(results):
				print("todo initial")
				let todos = Array(results)
				completion?(.success(todos))
			case let .update(results, _, _, _):
				print("todo update")
				let todos = Array(results)
				completion?(.success(todos))
			case let .error(error):
				print(error.localizedDescription)
			}
		})
	}
	
	func fetchLists(completion: ((Result<[ListRealm], Never>) -> Void )?) {
		let lists =  realm.objects(ListRealm.self)
		notificationTokens.append(lists.observe { change in
			switch change {
			case let .initial(results):
				print("ListRealm initial")
				let lists = Array(results)
				completion?(.success(lists))
			case let .update(results, _, _, _):
				print("ListRealm update")
				let lists = Array(results)
				completion?(.success(lists))
			case let .error(error):
				print(error.localizedDescription)
			}
		})
	}
	
	func updateTodoStatusById(_ id: String) {
		let todo = realm.object(ofType: Todo.self, forPrimaryKey: id)
		if let todo = todo {
			do {
				try realm.write {
					todo.status!.finished.toggle()
				}
			} catch {
				print(error)
			}
		} else {
			print("todo not found")
		}
	}
}

// Control ⌃ + Option ⌥ + Command ⌘ + F .
//class ViewModel: ObservableObject {
//	@Published var itemEntities: Results<ItemEntity> = ItemEntity.all()
//	private var notificationTokens: [NotificationToken] = []
//
//	init() {
//		// DBに変更があったタイミングでitemEntitiesの変数に値を入れ直す
//		notificationTokens.append(itemEntities.observe { change in
//			switch change {
//			case let .initial(results):
//				self.itemEntities = results
//			case let .update(results, _, _, _):
//				self.itemEntities = results
//			case let .error(error):
//				print(error.localizedDescription)
//			}
//		})
//	}
//
//	deinit {
//		notificationTokens.forEach { $0.invalidate() }
//	}
//}
