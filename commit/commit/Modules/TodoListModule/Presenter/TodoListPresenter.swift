//
//  TodoListPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import Foundation
import RealmSwift

class TodoListPresenter: ObservableObject {
	struct Dependency {
		let listFetchInteractor: AnyUseCase<Void, [ListRealm], Never>
		let todoFetchInteractor: AnyUseCase<String, [Todo], Never>
		let todoUpdateInteractor: AnyUseCase<String, Void, Never>
	}
	
	@Published var lists: [ListRealm] = []
	@Published var todos: [[Todo]] = []
	@Published var currentList: ListRealm?
	@Published var currentSection: [SectionRealm] = []
	
	private let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func onAppear() {
		dependency.listFetchInteractor.execute(()) { [weak self] result in
			switch result {
				case .success(let lists):
					self?.lists = lists
					self?.currentList = lists[0]
					self?.currentSection = Array(lists[0].sections)
					for section in lists[0].sections {
						self?.fetchTodo(id: section.id)
					}
			}
		}
	}
	
	func updateTodoStatus(id: String) {
		dependency.todoUpdateInteractor.execute(id) { result in
			switch result {
				case .success:
					print(self.todos.count)
			}
		}
	}
	
	private func fetchTodo(id: String) {
		dependency.todoFetchInteractor.execute(id) { [weak self] result in
			switch result {
				case .success(let sectionTodos):
					let sectionId = sectionTodos[0].sectionId
					var index: Int? = nil
					// NOTE: 計算量うんこなので、もうちょっと方法考える
					// Review: 変数名ゴミ
					for todo in self!.todos where sectionId == todo[0].sectionId {
						index = self!.todos.firstIndex(of: todo)!
						self!.todos.remove(at: index!)
					}
					
					if let index = index {
						self!.todos.insert(sectionTodos, at: index)
					} else {
						self!.todos.append(sectionTodos)
					}
			}
		}
	}
	
}

//extension TodoListPresenter {
//	static let sample: TodoListPresenter = {
//		let repository = SampleTodoRepository()
//		let listFetchInteractor = AnyUseCase(ListFetchInteractor(repository: repository))
//		let todoFetchInteractor = AnyUseCase(TodoFetchInteractor(repository: repository))
//		let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor(repository: repository))
//		let dependency = TodoListPresenter.Dependency(
//			listFetchInteractor: listFetchInteractor,
//			todoFetchInteractor: todoFetchInteractor,
//			todoUpdateInteractor: todoUpdateInteractor)
//		return TodoListPresenter(dependency: dependency)
//	}()
//}
