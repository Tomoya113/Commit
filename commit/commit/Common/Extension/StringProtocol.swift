//
//  StringProtocol.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/14.
//

import Foundation

extension StringProtocol where Self: RangeReplaceableCollection {
  var removeWhitespacesAndNewlines: Self {
	filter { !$0.isNewline && !$0.isWhitespace }
  }
}
