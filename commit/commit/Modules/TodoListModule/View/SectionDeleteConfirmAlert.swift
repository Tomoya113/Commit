//
//  SectionDeleteConfirmAlert.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/30.
//

import SwiftUI

func sectionDeleteConfirmationAlert(
	action: @escaping () -> Void
) -> Alert {
	Alert(
		title: Text("セクションの削除"),
		message: Text("セクションを削除しますか？"),
		primaryButton: .cancel(
			Text("キャンセル"),
			action: {
				print("cancel")
			}
		),
		secondaryButton: .destructive(
			Text("削除"),
			action: {
				action()
			}
		)
	)
}
