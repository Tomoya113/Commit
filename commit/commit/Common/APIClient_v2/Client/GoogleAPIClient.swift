//
//  OldGoogleAPIClient.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/09/26.
//

import Foundation

class GoogleAPIClient {
	private let httpClient: HTTPClient
	
	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}
	
	func send<Request: GoogleAPIRequest>(
		request: Request,
		completion: @escaping (Result<Request.Response, GoogleAPIClientError<Request.APIError>>) -> Void) {
			let urlRequest = request.buildURLRequest()
			httpClient.sendRequest(urlRequest) { result in
				switch result {
					case .success((let data, let urlResponse)):
						do {
							let response = try
							request.response(from: data, urlResponse: urlResponse)
							completion(.success(response))
						} catch let error as Request.APIError {
							completion(.failure(.apiError(error)))
						} catch {
							completion(.failure(.responseParserError(error)))
						}
					case .failure(let error):
						completion(.failure(.connectionError(error)))
				}
			}
			
		}
}
