//
//  HTTPMethod.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/10.
//

import Foundation

// NOTE: getとputしか今の所使ってない
enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case head = "HEAD"
	case delete = "DELETE"
	case patch = "PATCH"
	case trace = "TRACE"
	case options = "OPTIONS"
	case connect = "CONNECT"
}
