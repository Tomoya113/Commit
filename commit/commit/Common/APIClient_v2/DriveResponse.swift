//
//  DriveResponse.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

struct DriveResponse: Decodable {
	var kind: String
	var files: [File]
	
	struct File: Decodable, Identifiable {
		var id: String
		var mimeType: String
		var kind: String
		var name: String
	}
}
