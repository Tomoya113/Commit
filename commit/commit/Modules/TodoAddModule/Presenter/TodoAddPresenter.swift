//
//  TodoAddPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import Foundation

class TodoAddPresenter: ObservableObject {
	struct Dependency {}
	@Published var title: String = ""
	@Published var subtitle: String = ""
	@Published var sectionIndex: Int = 0
	
	private let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

#if DEBUG
extension TodoAddPresenter {
	static let sample: TodoAddPresenter = {
		let dependency = TodoAddPresenter.Dependency()
		return TodoAddPresenter(dependency: dependency)
	}()
}

#endif
