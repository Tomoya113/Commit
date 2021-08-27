//
//  SheetsTodoAddFormView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import SwiftUI

struct SheetsTodoAddFormView: View {
	@Binding var sheetsPreset: SheetPreset
	@Binding var userResources: UserResources
	@Binding var sheetData: SheetData
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@State private var showConfirmView = false
	@State private var afterSaveData = false
	let fetchSheetsInfo: (() -> Void)
	let fetchCells: (() -> Void)
	let saveData: (() -> Void)
	var body: some View {
		Form {
			Section(header: Text("プリセット名"), footer: Text("セクション名になります")) {
				TextField("プリセット名", text: $sheetsPreset.title)
			}
			
			Section(header: Text("スプレッドシート")) {
				Picker("スプレッドシート", selection: $sheetsPreset.sheetsId) {
					ForEach(userResources.sheetsList) { file in
						Text(file.name)
							.tag(file.id)
							.buttonStyle(PlainButtonStyle())
					}
				}
				.onChange(of: sheetsPreset.sheetsId) { _ in
					fetchSheetsInfo()
				}
			}
			
			Section(header: Text("シート名")) {
				Picker("シート", selection: $sheetsPreset.tabName) {
					ForEach(userResources.tabList, id: \.title) { sheet in
						Text(sheet.title)
					}
				}
			}
			Section(header: Text("範囲")) {
				TextField("行", text: $sheetsPreset.row)
				// NOTE: A~Cなど
				Picker("最初：", selection: $sheetsPreset.column.start) {
					ForEach(SheetColumnEnum.allCases, id: \.self) { column in
						Text(column.rawValue)
							.tag(column as SheetColumnEnum?)
					}
				}
				Picker("最後：", selection: $sheetsPreset.column.end) {
					endRange
				}
			}
			Section(header: Text("書き込む行"), footer: Text("TODOを達成した時に書き込む行を指定します")) {
				TextField("行", text: $sheetsPreset.targetRow)
			}
			// https://stackoverflow.com/questions/63839821/swiftui-navigationlink-is-not-working-with-a-button
			NavigationLink(
				destination:
					SheetConfirmView {
						showConfirmView = false
						afterSaveData = true
						saveData()
					}
					.environmentObject(sheetData)
					.onDisappear {
						if afterSaveData {
							presentationMode.wrappedValue.dismiss()
						}
					},
				isActive: $showConfirmView,
				label: {
					Text("次へ")
						.multilineTextAlignment(.center)
						.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
						.foregroundColor(.blue)
				}
			)
			.simultaneousGesture(TapGesture().onEnded {
				print("fetchcells")
				fetchCells()
				showConfirmView = true
			})
		}
	}

	private var endRange: some View {
		if let start = sheetsPreset.column.start {
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

struct SheetsTodoAddFormView_Previews: PreviewProvider {
	@State static var sheetsPreset = SheetPreset()
	@State static var array = UserResources()
	@State static var sheetData = SheetData()
	static func test() {
		
	}
	
	static func hoge(_ completion: () -> Void) {
		completion()
	}
	
	static var previews: some View {
		NavigationView {
			SheetsTodoAddFormView(
				sheetsPreset: $sheetsPreset,
				userResources: $array,
				sheetData: $sheetData,
				fetchSheetsInfo: test,
				fetchCells: test,
				saveData: test
			)
		}
	}
}
