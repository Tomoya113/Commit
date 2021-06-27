//
//  TodoListRepository.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

import Foundation
import RealmSwift

class TodoListRepository: TodoRepositoryProtocol {
	
	let realm = try! Realm()
	private var notificationTokens: [NotificationToken] = []
	
	func findTodosById(_ id: String, completion: ((Result<[Todo], Never>) -> Void)?) {
		let todos = realm.objects(Todo.self).filter("sectionId == %@", id)
		notificationTokens.append(todos.observe { change in
			switch change {
			case let .initial(results):
				let todos = Array(results)
				completion?(.success(todos))
			case let .update(results, _, _, _):
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
				let lists = Array(results)
				completion?(.success(lists))
			case let .update(results, _, _, _):
				let lists = Array(results)
				completion?(.success(lists))
			case let .error(error):
				print(error.localizedDescription)
			}
		})
	}
	
	func updateTodoStatusById(_ id: String) {
		let todo = realm.object(ofType: Todo.self, forPrimaryKey: id)
		// NOTE: guard節で書いたほうがよくない？
		if let todo = todo {
			do {
				try realm.write {
					todo.status!.finished.toggle()
				}
			} catch {
				print(error.localizedDescription)
			}
		} else {
			print("todo not found")
		}
	}
	
	func updateTodo(_ todo: Todo) {
		do {
			try realm.write {
				realm.add(todo, update: .modified)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	deinit {
		notificationTokens.forEach { $0.invalidate() }
	}
}
