//
//  GoogleAPIRequest.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

protocol GoogleAPIRequest {
	associatedtype Response: Decodable
	associatedtype APIError: Error & Decodable
	
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var queryItems: [URLQueryItem] { get }
	var body: [String: Any]? { get }
	var token: String { get }
}

extension GoogleAPIRequest {
	var token: String {
		return GoogleOAuthManager.shared.token
	}
	
	func buildURLRequest() -> URLRequest {
		let url = baseURL.appendingPathComponent(path)
		let percentEndcodedPath = url.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
		
		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
		// NOTE: ここ動かなさそう
		components?.percentEncodedPath = percentEndcodedPath
		
		switch method {
			case .get:
				components?.queryItems = queryItems
			default:
				fatalError("Unsupported method \(method)")
		}
		
		var urlRequest = URLRequest(url: url)
		urlRequest.url = components?.url
		urlRequest.httpMethod = method.rawValue
		urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: HTTPField.AUTHORIZATION.rawValue)
		urlRequest.addValue("application/json", forHTTPHeaderField: HTTPField.CONTENT_TYPE.rawValue)
		urlRequest.addValue("application/json", forHTTPHeaderField: HTTPField.ACCEPT.rawValue)
		
		if let body = body {
			do {
				urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
			} catch {
				print("Something went wrong")
				fatalError(error.localizedDescription)
			}
		}
		
		return urlRequest
	}
	
	func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
		let decoder = JSONDecoder()
		
		if (200..<300).contains(urlResponse.statusCode) {
			return try decoder.decode(Response.self, from: data)
		} else {
			throw try decoder.decode(APIError.self, from: data)
		}
	}
}
