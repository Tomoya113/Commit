//
//  SpreadSheetFromView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import SwiftUI

struct SpreadSheetFormView: View {
	@State private var text: String = ""
	@Binding var spreadSheetPreset: SpreadSheetPreset
    var body: some View {
		Form {
			Section(header: Text("プリセット名"), footer: Text("セクション名になります")) {
				TextField("プリセット名", text: $spreadSheetPreset.title)
			}
			Section(header: Text("スプレッドシート名")) {
				Picker("Spread Sheet Id", selection: $spreadSheetPreset.spreadSheetId) {
					
				}
			}
			Section(header: Text("シート名")) {
				TextField("シート名", text: $spreadSheetPreset.tabName)
			}
			Section(header: Text("行"), footer: Text("半角数字でよろ")) {
				TextField("行", text: $spreadSheetPreset.row)
			}
			Section(header: Text("列")) {
				// NOTE: A~Cなど
				TextField("何列目から", text: $spreadSheetPreset.column.start)
				TextField("何列目まで", text: $spreadSheetPreset.column.end)
			}
		}
    }
}

struct SpreadSheetFromView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			SpreadSheetFormView()
		}
    }
}
