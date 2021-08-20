//
//  NormalTodoAddPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/13.
//

import Foundation
import SwiftUI

class NormalTodoAddPresenter: ObservableObject {
	struct Dependency {
		let todoCreateInteractor: AnyUseCase<AddTodoQuery, Void, Never>
		let sectionAddInteractor: AnyUseCase<SectionRealm, Void, Never>
		let fetchAllSectionsInteractor: AnyUseCase<String, [SectionRealm], Never>
	}
	@Published var title: String = ""
	@Published var subtitle: String = ""
	@Published var selectedSectionId: String = ""
	@Published var isActive: Bool = false
	@Published var sectionTitle: String = ""
	@Published var sections: [SectionRealm] = []
	
	private let dependency: Dependency
	private let router = NormalTodoAddRouter()
	
	// ここにsection書くのよくなさそう
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func createNewTodo() {
		let query = AddTodoQuery(
			sectionId: selectedSectionId,
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
	
	func addSection(title: String) {
		let section = SectionRealm(title: title, todos: [])
		selectedSectionId = section.id
		dependency.sectionAddInteractor.execute(section, completion: nil)
	}
	
	func fetchAllSections() {
		print("fetchAllSections")
		dependency.fetchAllSectionsInteractor.execute("") { result in
			switch result {
				case .success(let sections):
//					self.selectedSectionId = sections[0].id
//					for section in sections {
//						self.sections.append(section)
//					}
					self.sections = sections
			}
		}
	}
	
}

#if DEBUG
extension NormalTodoAddPresenter {
	static let sample: NormalTodoAddPresenter = {
		let dependency = NormalTodoAddPresenter.Dependency(
			todoCreateInteractor: AnyUseCase(TodoCreateInteractor()),
			sectionAddInteractor: AnyUseCase(SectionAddInteractor()),
			fetchAllSectionsInteractor: AnyUseCase(FetchAllSectionsInteractor())
		)
		return NormalTodoAddPresenter(dependency: dependency)
	}()
}
#endif
