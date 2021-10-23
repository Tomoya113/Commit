//
//  SheetsAPIError.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/24.
//

import Foundation

struct SheetsAPIError: Decodable, Error {
	var error: Body
	struct Body: Decodable, Error {
		var code: Int
		var message: String
		var status: String
	}
}

// NOTE: エラーの内容はこちら→ https://mixedanalytics.com/knowledge-base/api-connector-error-messages/

// NOTE: エラーの例

// [{
//   "error": {
//	 "code": 400,
//	 "message": "Unable to parse range: 見る用!C3:",
//	 "status": "INVALID_ARGUMENT"
//   }
// }]

// {
//   "error": {
//   "code": 404,
//	 "message": "Requested entity was not found.",
//	 "status": "NOT_FOUND"
//   }
// }
