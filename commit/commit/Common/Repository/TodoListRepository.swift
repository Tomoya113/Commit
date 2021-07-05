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
	
	func createNewTodo(todo: Todo, completion: ((Result<Void, Never>) -> Void)?) {
		do {
			try realm.write {
				realm.add(todo)
			}
			completion?(.success(()))
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func createNewTodo(query: AddTodoQuery, completion: ((Result<Void, Never>) -> Void)?) {
		let section = realm.object(ofType: SectionRealm.self, forPrimaryKey: query.sectionId)!
		do {
			try realm.write {
				section.todos.append(query.todo)
			}
			completion?(.success(()))
		} catch {
			print(error.localizedDescription)
		}
	}
	deinit {
		notificationTokens.forEach { $0.invalidate() }
	}
}
