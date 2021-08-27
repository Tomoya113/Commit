//
//  SheetPresetQuery.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation

struct SheetPresetQuery {
	var sheetsId: String
	var title: String
	var tabName: String
	var column: SheetPresetQueryColumn
	var row: String
	var targetRow: String
}

struct SheetPresetQueryColumn {
	var start: String
	var end: String
}
