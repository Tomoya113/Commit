//
//  TodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI
import RealmSwift

struct TodoAddView: View {
	let TODO_TYPE_TAB_PADDING: CGFloat = 16
	@StateObject var presenter: TodoAddPresenter
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		VStack(alignment: .center) {
			HStack(alignment: .center) {
				Spacer()
				todoTypeTab()
					.padding(TODO_TYPE_TAB_PADDING)
				Spacer()
			}
			if presenter.currentTodoType == .normal {
				presenter.normalTodoAddLinkBuilder()
			} else if presenter.currentTodoType == .sheets {
				presenter.sheetsTodoAddLinkBuilder()
			}
			Spacer()
			
		}
		.environmentObject(
			TodoAddPresenter.PresentationState(presentationMode: presentationMode))
		.onAppear {
			// NOTE: 毎回フェッチすると、子Viewがリロードされてフォームがリセットされるので、onAppearで初回判定をする
			presenter.onAppear()
		}
		.gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
					.onEnded({ value in
						didSwipe(value)
					}))
		.navigationBarTitle("TODOを追加", displayMode: .inline)
		.navigationBarItems(
			leading:
				Button(
					action: {
						dismiss()
					},
					label: {
						Text("キャンセル")
					}
				)
		)
	}
	
	private func dismiss() {
		presentationMode.wrappedValue.dismiss()
	}
	
	private func todoTypeTab() -> some View {
		Picker("Current todo type", selection: $presenter.currentTodoType) {
			ForEach(TodoTypes.allCases.indices) { i in
				Text(TodoTypes.allCases[i].rawValue)
					.tag(TodoTypes.allCases[i])
			}
		}
		.pickerStyle(SegmentedPickerStyle())
	}
	
	private func didSwipe(_ value: DragGesture.Value) {
		// 左にスワイプされたとき
		if value.translation.width < -150 {
			presenter.currentTodoTypeIndex -= 1
			if presenter.currentTodoTypeIndex <= -1 {
				presenter.currentTodoTypeIndex = TodoTypes.allCases.count - 1
			}
			presenter.currentTodoType = TodoTypes.allCases[presenter.currentTodoTypeIndex]
		}
		// 右にスワイプされたとき
		if value.translation.width > 150 {
			presenter.currentTodoTypeIndex += 1
			if presenter.currentTodoTypeIndex >= TodoTypes.allCases.count {
				presenter.currentTodoTypeIndex = 0
			}
			presenter.currentTodoType = TodoTypes.allCases[presenter.currentTodoTypeIndex]
		}
	}
	
}

#if DEBUG
struct TodoAddView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			TodoAddView(presenter: TodoAddPresenter.sample)
		}
	}
}
#endif
