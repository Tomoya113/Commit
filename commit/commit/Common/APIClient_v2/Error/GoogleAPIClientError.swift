//
//  GoogleAPIClientError.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

enum GoogleAPIClientError<APIError: Error>: Error {
	// 通信に失敗
	case connectionError(Error)
	
	// レスポンスの解釈に失敗
	case responseParserError(Error)
	
	// APIからエラーレスポンスを受け取った
	case apiError(APIError)
}
