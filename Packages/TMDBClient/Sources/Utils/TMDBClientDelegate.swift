//
//  TMDBClientDelegate.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Foundation
import Get

open class TMDBClientDelegate {
    private var apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension TMDBClientDelegate: APIClientDelegate {
    public func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        let queryItem = URLQueryItem(name: "api_key", value: apiKey)
        if !apiKey.isEmpty,
           let urlString = request.url?.absoluteString,
           var urlComponents = URLComponents(string: urlString) {
            var queryItems = urlComponents.queryItems ?? []
            queryItems.append(queryItem)
            urlComponents.queryItems = queryItems
            if let url = urlComponents.url {
                request.url = url
            }
        }
    }
    
    public func client(_ client: APIClient, validateResponse response: HTTPURLResponse, data: Data, task: URLSessionTask) throws {
        if response.statusCode != 200 {
            if let movieDBError = try? JSONDecoder().decode(TMDBError.self, from: data) {
                throw movieDBError
            }
            throw APIError.unacceptableStatusCode(response.statusCode)
        }
    }
}
