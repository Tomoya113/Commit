//
//  SpreadSheetView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/26.
//

import SwiftUI

struct SpreadSheetView: View {
//	@EnvironmentObject var GoogleAuth: GameSettings
	@State var text: String = ""
	var body: some View {
		Form {
			Section(header: Text("スプレッドシート名")) {
				TextField("タスク名", text: $text)
			}
			Section(header: Text("シート名")) {
				TextField("シート名", text: $text)
			}
			Section(header: Text("セクション名")) {
				TextField("セクション名", text: $text)
			}
			Section(header: Text("行")) {
				TextField("行", text: $text)
			}
			Section(header: Text("列")) {
				TextField("最初", text: $text)
				TextField("最後", text: $text)
			}
		}
	}
}

struct SpreadSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SpreadSheetView()
    }
}
