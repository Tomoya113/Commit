//
//  TodoDetailPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation
import RealmSwift
import Combine

class TodoDetailPresenter: ObservableObject {
	struct Dependency {
		let deleteTodoInteractor: AnyUseCase<Todo, Void, Never>
		let fetchSheetsCellInteractor: AnyUseCase<Todo, String, Error>
		// todoだけアップデート
		let todoUpdateInteractor: AnyUseCase<Todo, Void, Never>
		// NOTE: スプシに書き込み(NeverじゃなくてErrorに書き換えたほうが良さそう)
		let writeSheetsInteractor: AnyUseCase<Todo, Void, Never>
	}
	
	@Published var todo: Todo
	@Published var detail: String = ""
	@Published var finished: Bool = false
	private let dependency: Dependency
	private var cancellables: Set<AnyCancellable> = Set()
	
	init(dependency: Dependency, todo: Todo) {
		self.dependency = dependency
		self.todo = todo
		self.detail = todo.status!.detail
		self.finished = todo.status!.finished
		
		$detail
			.dropFirst()
			.debounce(for: 0.5, scheduler: DispatchQueue.main)
			.sink { _ in
				// NOTE:書き始めた時にDONEになってたらそれを外す()
				// 備考orDONE押すかの二択という方針で一旦
				// ここどうすればいいかわからん
				self.finished = false
				// updateTodoInteractorとwriteSheetInteractorを実行
				self.updateTodo(detail: self.detail, finished: self.finished)
			}
			.store(in: &cancellables)
		
		$finished
			.dropFirst()
			.debounce(for: 0.5, scheduler: DispatchQueue.main)
			.sink { _ in
				self.updateTodo(detail: self.detail, finished: self.finished)
			}
			.store(in: &cancellables)
	}
	
	func deleteTodo(action: (() -> Void)?) {
		dependency.deleteTodoInteractor.execute(todo) { result in
			switch result {
				case .success:
					action?()
			}
		}
	}
	
	func updateTodoIfNeeded() {
		if todo.type != .googleSheets {
			return
		}
		dependency.fetchSheetsCellInteractor.execute(todo) { result in
			print("update")
			switch result {
				case .success(let detail):
					self.updateTodo(detail: detail, finished: false)
					// NOTE: ここtrueにするか怪しい
				case .failure(let error):
					print("localizedDescription")
					print(error.localizedDescription)
			}
		}
	}
	
	// ここの仕様ちゃんと決めたほうが良い
	func updateTodo(detail: String, finished: Bool) {
	
		let _finished = detail == "DONE" ? true : finished
		let newTodo = Todo(
			title: todo.title,
			detail: "",
			displayTag: Array(todo.tags),
			todoType: todo.type
		)
		newTodo.id = todo.id
		newTodo.status!.detail = detail
		newTodo.status!.finished = _finished
		dependency.todoUpdateInteractor.execute(newTodo, completion: nil)
		writeSheet(todo: newTodo)
	}
	
	func writeSheet(todo: Todo) {
		dependency.writeSheetsInteractor.execute(todo, completion: nil)
	}
}

#if DEBUG
extension TodoDetailPresenter {	
	static let sample: TodoDetailPresenter = {
		let deleteTodoInteractor = AnyUseCase(DeleteTodoInteractor())
		let fetchSheetsCellInteractor = AnyUseCase(FetchSheetsCellInteractor())
		let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor())
		let writeSheetsInteractor = AnyUseCase(WriteSheetsInteractor())
		let dependency = TodoDetailPresenter.Dependency(
			deleteTodoInteractor: deleteTodoInteractor,
			fetchSheetsCellInteractor: fetchSheetsCellInteractor,
			todoUpdateInteractor: todoUpdateInteractor,
			writeSheetsInteractor: writeSheetsInteractor
		)
		return TodoDetailPresenter(dependency: dependency, todo: TodoMock.todoA1)
	}()
}

#endif
