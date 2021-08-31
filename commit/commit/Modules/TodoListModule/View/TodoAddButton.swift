//
//  TodoAddButton.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/31.
//

import SwiftUI

struct TodoAddButton: View {
    var body: some View {
		Image(systemName: "pencil")
			.frame(width: 60, height: 60)
			.imageScale(.large)
			.background(Color.green)
			.foregroundColor(.white)
			.clipShape(Circle())
    }
}

struct TodoAddButton_Previews: PreviewProvider {
    static var previews: some View {
        TodoAddButton()
    }
}
