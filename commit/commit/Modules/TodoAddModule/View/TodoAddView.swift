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
	@State private var currentTodoTypeIndex: Int = 0
	var body: some View {
		GeometryReader { geometry in
			VStack {
				todoTypeList()
				.frame(width: geometry.size.width - 24)
				if presenter.currentTodoType == .normal {
					presenter.normalTodoAddLinkBuilder(sections: $presenter.currentSection)

				} else if presenter.currentTodoType == .spreadSheet {
					presenter.spreadSheetAddLinkBuilder()
				}
				Spacer()
			}
		}
		.onAppear {
			// NOTE: 毎回フェッチすると、子Viewがリロードされてフォームがリセットされるので、onAppearで初回判定をする
			presenter.onAppear()
		}
		.gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
					.onEnded({ value in
						didSwipe(value)
					}))
		.navigationTitle("Todoを追加")
	}
	
	private func todoTypeList() -> some View {
		Picker("Current todo type", selection: $currentTodoTypeIndex) {
			ForEach(TodoTypes.allCases.indices) { i in
				Text(TodoTypes.allCases[i].rawValue)
			}
		}
		.pickerStyle(SegmentedPickerStyle())
	}

	private func didSwipe(_ value: DragGesture.Value) {
		// 左にスワイプされたとき
		if value.translation.width < -5 {
			currentTodoTypeIndex -= 1
			if currentTodoTypeIndex <= -1 {
				currentTodoTypeIndex = TodoTypes.allCases.count - 1
			}
			presenter.currentTodoType = TodoTypes.allCases[currentTodoTypeIndex]
		}
		// 右にスワイプされたとき
		if value.translation.width > 5 {
			currentTodoTypeIndex += 1
			if currentTodoTypeIndex >= TodoTypes.allCases.count {
				currentTodoTypeIndex = 0
			}
			presenter.currentTodoType = TodoTypes.allCases[currentTodoTypeIndex]
		}
	}
	
}
struct TodoAddView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			TodoAddView(presenter: TodoAddPresenter.sample)
		}
	}
}
