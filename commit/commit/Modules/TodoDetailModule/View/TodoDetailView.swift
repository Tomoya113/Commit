//
//  TodoDetailView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct TodoDetailView: View {
	@State private var title = ""
	@State private var detail = ""
	@State private var finished = false
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
		VStack {
			Form {
				Section(header: Text("タスク名")) {
					TextField("タスク名", text: $title)
				}
				Section(header: Text("状態")) {

					Toggle(finished ? "DONE" : "未達成", isOn: $finished)
				}
				Section(header: Text("説明"), footer: Text("任意の文字列を設定することが出来ます。\nDoneは") + Text(Image(systemName: "checkmark.square.fill")) + Text("と表示されます。")) {
					TextField("任意の説明", text: $detail)
				}
			}
			Button(action: {
				self.presentationMode.wrappedValue.dismiss()
			}, label: {
				Text("更新")
					.frame(minWidth: 0, maxWidth: .infinity - 50)
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
    static var previews: some View {
		NavigationView {
			TodoDetailView()
				.navigationBarTitle("タスクの編集", displayMode: .inline)
				.navigationViewStyle(StackNavigationViewStyle())
				.environment(\.locale, Locale(identifier: "ja_JP"))
		}
    }
}
