//
//  TodoDetailView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct TodoDetailView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@ObservedObject var presenter: TodoDetailPresenter
    var body: some View {
		VStack {
			Form {
				Section(header: Text("タスク名")) {
					TextField("タスク名", text: $presenter.title)
				}
				Section(header: Text("状態")) {
					Toggle(presenter.finished ? "DONE" : "未達成", isOn: $presenter.finished)
				}
				Section(header: Text("説明"), footer: Text("任意の文字列を設定することが出来ます。\nDoneは") + Text(Image(systemName: "checkmark.square.fill")) + Text("と表示されます。")) {
					TextField("任意の説明", text: $presenter.detail)
				}
			}
			Button(action: {
				self.presenter.updateTodo {_ in
					self.presentationMode.wrappedValue.dismiss()
				}
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
		}
    }
}

struct TodoDetailView_Previews: PreviewProvider {
	static var sample = TodoDetailPresenter.sample
    static var previews: some View {
		NavigationView {
			TodoDetailView(presenter: sample)
				.navigationBarTitle("タスクの編集", displayMode: .inline)
				.navigationViewStyle(StackNavigationViewStyle())
				.environment(\.locale, Locale(identifier: "ja_JP"))
		}
    }
}
