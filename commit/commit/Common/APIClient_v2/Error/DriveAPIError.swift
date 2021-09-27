//
//  DriveAPIError.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/24.
//

import Foundation

struct DriveAPIError: Decodable, Error {
	struct Error: Decodable {
		var domain: String
		var reason: String
		var message: String
		var locationType: String
		var location: String
	}
	var errors: [Error]
	var code: Int
	var message: String
}

// NOTE: エラーの例

//    {
//     "error": {
//      "errors": [
//       {
//    	"domain": "global",
//    	"reason": "invalid",
//    	"message": "Invalid Value",
//    	"locationType": "parameter",
//    	"location": "orderBy"
//       }
//      ],
//      "code": 400,
//      "message": "Invalid Value"
//     }
//    }
