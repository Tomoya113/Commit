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
    var body: some View {
		Form {
			Section(header: Text("タスク名")) {
				TextField("タスク名", text: $title)
			}
			Section(header: Text("状態")) {
				TextField("タスク名", text: $title)
			}
			Section(header: Text("説明"), footer: Text("任意の文字列を設定することが出来ます。\nDoneは") + Text(Image(systemName: "checkmark.square.fill")) + Text("と表示されます。")) {
				TextField("任意の説明", text: $detail)
			}
		}
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			TodoDetailView()
				.navigationBarTitle("hoge", displayMode: .inline)
				.navigationViewStyle(StackNavigationViewStyle())
		}
		
    }
}
