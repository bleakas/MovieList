//
//  TMDBClientDelegate.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Foundation
import Get

public struct TMDBClientDelegate {
    private var apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension TMDBClientDelegate: APIClientDelegate {
    public func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        let queryItem = URLQueryItem(name: "api_key", value: apiKey)
        if let urlString = request.url?.absoluteString,
           var urlComponents = URLComponents(string: urlString) {
            var queryItems = urlComponents.queryItems ?? []
            queryItems.append(queryItem)
            urlComponents.queryItems = queryItems
            if let url = urlComponents.url {
                request.url = url
            }
        }
    }
}
