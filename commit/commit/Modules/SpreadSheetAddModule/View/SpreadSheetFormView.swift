//
//  SpreadSheetFromView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import SwiftUI

struct SpreadSheetFormView: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@Binding var spreadSheetPreset: SheetPreset
	@Binding var userResources: UserResources
	let fetchSpreadSheetInfo: (() -> Void)
	let fetchCells: (() -> Void)
	var body: some View {
		Form {
			Section(header: Text("プリセット名"), footer: Text("セクション名になります")) {
				TextField("プリセット名", text: $spreadSheetPreset.title)
			}
			
			Section(header: Text("スプレッドシート")) {
				Picker("スプレッドシート", selection: $spreadSheetPreset.spreadSheetId) {
					ForEach(userResources.spreadSheetList) { file in
						Text(file.name)
							.tag(file.id)
							.buttonStyle(PlainButtonStyle())
					}
				}
				.onChange(of: spreadSheetPreset.spreadSheetId) { _ in
					fetchSpreadSheetInfo()
				}
			}
			
			Section(header: Text("シート名")) {
				Picker("シート", selection: $spreadSheetPreset.tabName) {
					ForEach(userResources.tabList, id: \.title) { sheet in
						Text(sheet.title)
					}
				}
			}
			Section(header: Text("範囲")) {
				TextField("行", text: $spreadSheetPreset.row)
				// NOTE: A~Cなど
				Picker("最初：", selection: $spreadSheetPreset.column.start) {
					ForEach(SheetColumnEnum.allCases, id: \.self) { column in
						Text(column.rawValue)
							.tag(column as SheetColumnEnum?)
					}
				}
				Picker("最後：", selection: $spreadSheetPreset.column.end) {
					endRange
				}
			}
			Section(header: Text("書き込む行"), footer: Text("TODOを達成した時に書き込む行を指定します")) {
				TextField("行", text: $spreadSheetPreset.targetRow)
			}
		}
		SubmitButton {
			fetchCells()
			presentationMode.wrappedValue.dismiss()
		}
	}
	private var endRange: some View {
		if let start = spreadSheetPreset.column.start {
			return (
				ForEach(SheetColumnEnum.getRange(start), id: \.self) { column in
					Text(column.rawValue)
						.tag(column as SheetColumnEnum?)
				}
			)
		} else {
			// NOTE: これはよくなさそう
			return (
				ForEach(SheetColumnEnum.allCases, id: \.self) { column in
					Text(column.rawValue)
						.tag(column as SheetColumnEnum?)
				}
			)
		}
	}
}

struct SpreadSheetFromView_Previews: PreviewProvider {
	@State static var spreadSheetPreset = SheetPreset()
	@State static var array = UserResources()
	static func test() {
		
	}
	
	static var previews: some View {
		NavigationView {
			SpreadSheetFormView(
				spreadSheetPreset: $spreadSheetPreset,
				userResources: $array,
				fetchSpreadSheetInfo: test,
				fetchCells: test
			)
		}
	}
}
