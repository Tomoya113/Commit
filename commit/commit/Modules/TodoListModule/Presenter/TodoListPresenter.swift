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
	}
	
	@Published var lists: [ListRealm] = []
	@Published var currentList: ListRealm?
	
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
						self?.currentList = lists[0]
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
			let dependency = TodoListPresenter.Dependency(
				listFetchInteractor: listFetchInteractor,
				todoUpdateInteractor: todoUpdateInteractor)
			return TodoListPresenter(dependency: dependency)
		}()
	}
#endif
