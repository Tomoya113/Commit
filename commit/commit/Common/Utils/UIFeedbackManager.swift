//
//  UIFeedbackManager.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/08.
//

import Foundation
import UIKit

class UIFeedbackManager {
	private let lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
	static let shared = UIFeedbackManager()
	
	func lightImpact() {
		lightImpactGenerator.impactOccurred()
	}
	
}
