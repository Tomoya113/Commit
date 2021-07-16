//
//  NormalTodoAddPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import Foundation

class NormalTodoAddPresenter: ObservableObject {
	struct Dependency {
		let todoCreateInteractor: AnyUseCase<AddTodoQuery, Void, Never>
	}
	@Published var title: String = ""
	@Published var subtitle: String = ""
	@Published var currentSectionId: String = ""
	
	private let dependency: Dependency
	
	// ここにsection書くのよくなさそう
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func createNewTodo() {
		let query = AddTodoQuery(
			sectionId: currentSectionId,
			todo: Todo(
				title: title,
				detail: subtitle,
				displayTag: [],
				todoType: .normal)
			)
		dependency.todoCreateInteractor.execute(query) { result in
			switch result {
				case .success(()):
					print("success")
			}
		}
	}
}

#if DEBUG
extension NormalTodoAddPresenter {
	static let sample: NormalTodoAddPresenter = {
		let dependency = NormalTodoAddPresenter.Dependency(
			todoCreateInteractor: AnyUseCase(TodoCreateInteractor()))
		return NormalTodoAddPresenter(dependency: dependency)
	}()
}
#endif
