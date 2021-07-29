//
//  TodoListPresenter.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/18.
//

import Foundation
import RealmSwift
import SwiftUI

class TodoListPresenter: ObservableObject {
	struct Dependency {
		let listFetchInteractor: AnyUseCase<Void, [ListRealm], Never>
		let todoUpdateInteractor: AnyUseCase<Todo, Void, Never>
		let deleteSectionInteractor: AnyUseCase<SectionRealm, Void, Never>
	}
	
	@Published var lists: [ListRealm] = []
	@Published var currentSections: [SectionRealm] = []
	
	private let dependency: Dependency
	private let router = TodoListRouter()
	private var isFirstAppear = false
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	func onAppear() {
		if !isFirstAppear {
			isFirstAppear = true
			dependency.listFetchInteractor.execute(()) { [weak self] result in
				switch result {
					case .success(let lists):
						self?.lists = lists
						let sections = lists[0].sections
						self?.currentSections = Array(sections)
				}
			}
		}
		
	}
	
	func updateTodoStatus(todo: Todo) {
		dependency.todoUpdateInteractor.execute(todo) { result in
			switch result {
				case .success:
					print("updated")
			}
		}
	}
	
	func deleteSection(_ index: Int) {
		if !lists.isEmpty {
			currentSections.remove(at: index)
			dependency.deleteSectionInteractor.execute(lists[0].sections[index]) { result in
				switch result {
					case .success:
						print("delete")
//						let sections = self.lists[0].sections
//						self.currentSections = Array(sections)
				}
			}
		}
	}
		
	func generateTodoRow(todo: Todo, updateTodoStatus: @escaping  () -> Void) -> some View {
		TodoListRow(todo: todo) {
			updateTodoStatus()
		}
	}
	
	func addTodoButtonImage() -> some View {
		Image(systemName: "pencil")
			.frame(width: 60, height: 60)
			.imageScale(.large)
			.background(Color.green)
			.foregroundColor(.white)
			.clipShape(Circle())
	}
	
	func actionSheet() -> ActionSheet {
		ActionSheet(
			title: Text("Todoの追加"),
			message: Text("追加するTodoの種類を選んでください"),
			buttons: [
				.default(Text("Normal"), action: {
					print("normal")
				}),
				.default(Text("SpreadSheetと連携"), action: {
					print("SpreadSheet")
				}),
				.cancel(Text("キャンセル"))
			]
		)
	}
	
	func detailViewLinkBuilder<Content: View>(for todo: Todo, @ViewBuilder content: () -> Content) -> some View {
		NavigationLink(destination: router.generateDetailView(for: todo)) {
			content()
		}
	}
	
	func todoAddLinkBuidler<Content: View>(sections: [SectionRealm], @ViewBuilder content: () -> Content) -> some View {
		return (
			NavigationLink(destination: router.generateTodoAddView(sections: sections)) {
				content()
			}
		)
	}
}

#if DEBUG
	extension TodoListPresenter {
		static let sample: TodoListPresenter = {
			let todoRepository = MockTodoRepository()
			let listFetchInteractor = AnyUseCase(ListFetchInteractor())
			let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor(todoRepository: todoRepository))
			let deleteSectionInteractor = AnyUseCase(DeleteSectionInteractor())
			let dependency = TodoListPresenter.Dependency(
				listFetchInteractor: listFetchInteractor,
				todoUpdateInteractor: todoUpdateInteractor,
				deleteSectionInteractor: deleteSectionInteractor
			)
			return TodoListPresenter(dependency: dependency)
		}()
	}
#endif
