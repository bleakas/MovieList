//
//  TMDBClientDelegateMock.swift
//  
//
//  Created by Pavel Shutkou on 05.02.23.
//

import Foundation
import Get
import TMDBClient

class TMDBClientDelegateMock {}

extension TMDBClientDelegateMock: APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        if let urlString = request.url?.absoluteString,
           var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = nil
            if let url = urlComponents.url {
                request.url = url
            }
        }
    }

    func client(_ client: APIClient, validateResponse response: HTTPURLResponse, data: Data, task: URLSessionTask) throws {
        if response.statusCode != 200 {
            if let movieDBError = try? JSONDecoder().decode(TMDBError.self, from: data) {
                throw movieDBError
            }
            throw APIError.unacceptableStatusCode(response.statusCode)
        }
    }
}
