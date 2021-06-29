//
//  TodoDetailPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation
import RealmSwift

class TodoDetailPresenter: ObservableObject {
	struct Dependency {
//		let updateTodoInteractor: AnyUseCase<Todo, Void, Never>
	}
	
	@ObservedRealmObject var todo: Todo
	private let dependency: Dependency
	
	init(dependency: Dependency, todo: Todo) {
		
		self.dependency = dependency
		self.todo = todo
	}
	
}

#if DEBUG
extension TodoDetailPresenter {
	static let sample: TodoDetailPresenter = {
		let dependency = TodoDetailPresenter.Dependency()
		return TodoDetailPresenter(dependency: dependency, todo: TodoMock.todoA1)
	}()
}

#endif
