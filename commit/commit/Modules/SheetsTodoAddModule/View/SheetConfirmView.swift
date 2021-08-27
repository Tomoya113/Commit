//
//  SheetConfirmView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/12.
//

import SwiftUI

struct SheetConfirmView: View {
	@EnvironmentObject var sheetData: SheetData
	var action: () -> Void
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("以下の内容で追加します")
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading, 20)
			List {
				Section(header: sectionTitle("書き込む行")) {
					Text("\(sheetData.preset.targetRow)行目")
				}
				Section(header: sectionTitle("追加するTodo")) {
					todoList(section: sheetData.section)
				}
			}
			SubmitButton(title: "追加") {
				action()
			}
			Spacer()
		}
		.navigationTitle(Text("確認"))
	}
	
	private func todoList(section: SectionRealm) -> some View {
		let todos = Array(section.todos)
		return (
			ForEach(todos, id: \.id) { todo in
				Text(todo.title)
			}
		)
	}
	
	private func sectionTitle(_ title: String) -> some View {
		return (
			Text(title).bold().font(.headline).foregroundColor(.black)
		)
	}
}

struct SheetConfirmView_Previews: PreviewProvider {
	@State static var sheetData: SheetData = SheetData()
	static var previews: some View {
		NavigationView {
			SheetConfirmView {
				print("hoge")
			}
			.environmentObject(sheetData)
		}
	}
}
