//
//  GoogleAccountSettingView.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/23.
//

import SwiftUI

struct GoogleAccountSettingView: View {
    var body: some View {
		List {
			HStack {
				Text("title")
				Spacer()
				Text("title")
					.font(.subheadline)
			}
			Toggle(isOn: .constant(true)) {
				Text("Label")
			}
			.navigationTitle(Text("アカウント設定"))
		}
		.listStyle(GroupedListStyle())
    }
}

struct GoogleAccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			GoogleAccountSettingView()
				.navigationTitle(
					Text("Googleアカウント連携")
				)
		}
        
    }
}
