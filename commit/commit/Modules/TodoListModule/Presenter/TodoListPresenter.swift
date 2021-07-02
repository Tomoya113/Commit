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
		let todoUpdateInteractor: AnyUseCase<String, Void, Never>
	}
	
	@Published var lists: [ListRealm] = []
	@Published var currentList: ListRealm?
	
	private let dependency: Dependency
	private let router = TodoListRouter()
	// NOTE: 絶対個々に書くやつではない
	private let repository: TodoRepositoryProtocol
	
	init(dependency: Dependency, repository: TodoRepositoryProtocol) {
		self.dependency = dependency
		self.repository = repository
	}
	
	func onAppear() {
		dependency.listFetchInteractor.execute(()) { [weak self] result in
			switch result {
				case .success(let lists):
					self?.lists = lists
					self?.currentList = lists[0]
			}
		}
	}
	
	func updateTodoStatus(id: String) {
		dependency.todoUpdateInteractor.execute(id) { result in
			switch result {
				case .success:
					print("updated")
			}
		}
	}
		
	func generateTodoRow(todo: Todo, updateTodoStatus: @escaping ((String) -> Void)) -> some View {
		TodoListRow(todo: todo, updateTodoStatus: updateTodoStatus)
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
	
	func linkBuilder<Content: View>(for todo: Todo, @ViewBuilder content: () -> Content) -> some View {
		NavigationLink(destination: router.generateDetailView(for: todo, repository: repository)) {
			content()
		}
	}
	
//	func todoAddLinkBuidler<Content: View>(@ViewBuilder content: () -> Content) -> some View {
//		NavigationLink(destination:)
//	}
	
//	func linkkBuilder<Content: View>(for todo: Todo, @ViewBuilder content: () -> Content) -> some View {
//		NavigationLink(destination: <#T##_#>, isActive:)
//	}
}

#if DEBUG
	extension TodoListPresenter {
		static let sample: TodoListPresenter = {
			let repository = MockTodoRepository()
			let listFetchInteractor = AnyUseCase(ListFetchInteractor(repository: repository))
			let todoUpdateInteractor = AnyUseCase(TodoUpdateInteractor(repository: repository))
			let dependency = TodoListPresenter.Dependency(
				listFetchInteractor: listFetchInteractor,
				todoUpdateInteractor: todoUpdateInteractor)
			return TodoListPresenter(dependency: dependency, repository: repository)
		}()
	}
#endif
