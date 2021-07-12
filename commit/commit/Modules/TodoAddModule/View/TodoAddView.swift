//
//  TodoAddView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI
import RealmSwift

struct TodoAddView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@ObservedObject var presenter: TodoAddPresenter
	var sections: [SectionRealm]
	@State private var currentTodoTypeIndex: Int = 0
	var body: some View {
		GeometryReader { geometry in
			
			VStack {
				Picker("Current todo type", selection: $currentTodoTypeIndex) {
					ForEach(TodoTypes.allCases.indices) { i in
						Text(TodoTypes.allCases[i].rawValue)
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.frame(width: geometry.size.width - 24)
				if presenter.currentTodoType == .normal {
					NormalTodoForm(
						title: $presenter.title,
						subtitle: $presenter.subtitle,
						sections: sections,
						currentSectionId: $presenter.currentSectionId
					)
				} else if presenter.currentTodoType == .spreadSheet {
					SpreadSheetAddView(presenter: SpreadSheetAddPresenter.sample)
				}
				Button(action: {
					didTapSubmitButton()
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
		.gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
					.onEnded({ value in
						didSwipe(value)
					}))
		.navigationTitle("Todoを追加")
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
	private func didTapSubmitButton() {
		presentationMode.wrappedValue.dismiss()
		presenter.createNewTodo()
	}
	
}
struct TodoAddView_Previews: PreviewProvider {
	static var sections = ListMock.list1.sections
	static var previews: some View {
		NavigationView {
			TodoAddView(presenter: TodoAddPresenter.sample, sections: Array(sections))
		}
	}
}
