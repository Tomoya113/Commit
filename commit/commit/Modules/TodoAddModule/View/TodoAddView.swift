//
//  TodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI
import RealmSwift

struct TodoAddView: View {
	@ObservedObject var presenter: TodoAddPresenter
	@State private var currentTodoType: Int = 0
	@State private var text: String = ""
	@State var todoType: TodoTypes = .normal
	var body: some View {
		GeometryReader { geometry in
			VStack {
				Picker("hoge", selection: $currentTodoType) {
					ForEach(TodoTypes.allCases.indices) { i in
						Text(TodoTypes.allCases[i].rawValue)
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.frame(width: geometry.size.width - 24)
				if todoType == .normal {
					normalTodoForm
				} else if todoType == .spreadSheet {
					spreadSheetTodoForm
				}
				Button(action: {
				}, label: {
					Text("更新")
						.fontWeight(.bold)
						.frame(minWidth: 0, maxWidth: .infinity)
						.font(.system(size: 18))
						.padding()
						.foregroundColor(.white)
						.background(Color.green)
						.cornerRadius(10)
				})
				.padding(
					EdgeInsets(
						top: -8,
						leading: 12,
						bottom: 0,
						trailing: 12)
				)
				Spacer()
			}
		}
		.gesture(DragGesture(minimumDistance: 5, coordinateSpace: .local)
					.onEnded({ value in
						didSwipe(value)
					}))
		.navigationTitle("Todoを追加")
	}
	private var normalTodoForm: some View {
		Form {
			Section(header: Text("タスク名 - normal")) {
				TextField("タスク名", text: $presenter.title)
			}
			Section(header: Text("説明")) {
				TextField("タスクの説明", text: $presenter.subtitle)
			}
			Picker(selection: $currentTodoType, label: Text("Type")) {
				ForEach(TodoTypes.allCases.indices) { i in
					Text(TodoTypes.allCases[i].rawValue)
				}
			}
		}
	}
	
	private var spreadSheetTodoForm: some View {
		Form {
			Section(header: Text("タスク名 - spreadSheet")) {
				TextField("タスク名", text: $presenter.title)
			}
			Section(header: Text("説明")) {
				TextField("タスクの説明", text: $presenter.subtitle)
			}
			
		}
	}
	private func didSwipe(_ value: DragGesture.Value) {
		// 左にスワイプされたとき
		if value.translation.width < -5 {
			currentTodoType -= 1
			if currentTodoType <= -1 {
				currentTodoType = TodoTypes.allCases.count - 1
			}
			todoType = TodoTypes.allCases[currentTodoType]
		}
		// 右にスワイプされたとき
		if value.translation.width > 5 {
			currentTodoType += 1
			if currentTodoType >= TodoTypes.allCases.count {
				currentTodoType = 0
			}
			todoType = TodoTypes.allCases[currentTodoType]
		}
	}
}
struct TodoAddView_Previews: PreviewProvider {
	static var previews: some View {
		TodoAddView(presenter: TodoAddPresenter.sample)
	}
}
