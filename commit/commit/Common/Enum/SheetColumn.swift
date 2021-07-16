//
//  SheetColumn.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/08.
//

import Foundation

// NOTE: 命名変えたい
enum SheetColumnEnum: String, CaseIterable {
	case A
	case B
	case C
	case D
	case E
	case F
	case G
	case H
	case I
	case J
	case K
	case L
	case M
	case N
	case O
	case P
	case Q
	case R
	case S
	case T
	case U
	case V
	case W
	case X
	case Y
	case Z
	case AA
	case AB
	case AC
	case AD
	case AE
	case AF
	case AG
	case AH
	case AI
	case AJ
	case AK
	case AL
	case AM
	case AN
	case AO
	case AP
	case AQ
	case AR
	case AS
	case AT
	case AU
	case AV
	case AW
	case AX
	case AY
	case AZ
	
	// NOTE: ちゃんと失敗するとき場合のエラーハンドリングをする
	static func getRange(_ from: Self, _ to: Self) -> [Self] {
		let rangeList = allCases
		let from = rangeList.firstIndex(of: from)!
		let to = rangeList.firstIndex(of: to)!
		return Array(rangeList[from...to])
	}
	
	static func getRange(_ from: Self) -> [Self] {
		let rangeList = allCases
		let from = rangeList.firstIndex(of: from)!
		return Array(rangeList[from..<allCases.count])
	}
}
