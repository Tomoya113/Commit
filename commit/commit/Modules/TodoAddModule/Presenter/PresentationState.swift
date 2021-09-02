//
//  PresentationState.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/03.
//

import SwiftUI

extension TodoAddPresenter {
	class PresentationState: ObservableObject {
		@Published var mode: Binding<PresentationMode>
		
		init(presentationMode: Binding<PresentationMode>) {
			self.mode = presentationMode
		}
		
		func dismiss() {
			mode.wrappedValue.dismiss()
		}
	}
}
