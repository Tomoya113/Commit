//
//  TodoDetailView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct TodoDetailView: View {
	@ObservedObject var presenter: TodoDetailPresenter
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@State var isSheetShowing: Bool = false
	var body: some View {
		VStack {
			Form {
				if !presenter.todo.isInvalidated {
					Section(header: Text("タスク名")) {
						TextField("タスク名", text: $presenter.todo.title)
						TextField("サブタイトル", text: $presenter.todo.subtitle)
					}
					Section(header: Text("状態"), footer: Text("任意の文字列を設定することが出来ます。\nDoneは") + Text(Image(systemName: "checkmark.square.fill")) + Text("と表示されます。")) {
						Toggle(presenter.todo.status!.finished ? "DONE" : "未達成", isOn: Binding($presenter.todo.status)!.finished)
						TextField("任意の説明", text: Binding($presenter.todo.status)!.detail)
					}
					
				}
				
			}
		}
		.toolbar(content: {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					self.isSheetShowing = true
				}, label: {
					Image(systemName: "trash")
				})
			}
		})
		.actionSheet(isPresented: $isSheetShowing) {
			actionSheet()
		}
	}
	
	private func actionSheet() -> ActionSheet {
		ActionSheet(
			title: Text("TODOの削除"),
			message: Text("本当にTODOを削除しますか？"),
			buttons: [
				.destructive(Text("削除")) {
					presenter.deleteTodo()
					self.presentationMode.wrappedValue.dismiss()
				},
				.cancel(Text("キャンセル"))
			]
		)
	}
}

struct TodoDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			TodoDetailView(presenter: TodoDetailPresenter.sample)
				.navigationBarTitle("タスクの編集", displayMode: .inline)
				.navigationViewStyle(StackNavigationViewStyle())
				.environment(\.locale, Locale(identifier: "ja_JP"))
		}
	}
}
