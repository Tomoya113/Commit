//
//  EmptySectionView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/30.
//

import SwiftUI

struct EmptySectionView: View {
	var body: some View {
		HStack(alignment: .center) {
			Spacer()
			Text("タスクがありません！")
			Spacer()
		}
	}
}

struct EmptySectionView_Previews: PreviewProvider {
	static var previews: some View {
		EmptySectionView()
	}
}
