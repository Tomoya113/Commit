//
//  TodoListPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import Foundation

class TodoListPresenter: ObservableObject {
	struct Dependency {
		let listSearchInteractor: AnyUseCase<Void, [ListRealm], Never>
		let todoSearchInteractor: AnyUseCase<String, [TodoProtocol], Never>
		let todoListUpdateInteractor: AnyUseCase<Void, Void, Never>
	}
	
	@Published var lists: [ListRealm] = []
	@Published var todos: [[TodoProtocol]] = []
	
	private let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func onAppear() {
		dependency.listSearchInteractor.execute(()) { [weak self] result in
			switch result {
			case .success(let lists):
				self?.lists = lists
				for section in lists[0].sections {
					self?.fetchTodo(id: section.id)
				}
			}
		}
	}
	
	func updateTodoStatus() {
		dependency.todoListUpdateInteractor.execute(()) { result in
			switch result {
			case .success:
				break
			}
		}
	}
	
	private func fetchTodo(id: String) {
		dependency.todoSearchInteractor.execute(id) { [weak self] result in
			switch result {
				case .success(let todos):
					self?.todos.append(todos)
			}
		}
	}
	
}
