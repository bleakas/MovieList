//
//  MovieBrowserAssembly.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Foundation
import Utilities
import Resolver
import TMDBClient
import Get

public final class MovieBrowserAssembly: Assembly {
    public func assemble(_ resolver: Resolver) {
        let baseURL = URL(string: "https://api.themoviedb.org/3")
        let apiKey = "815b63b537c380370911f6cb083031b0"
        let configuration = APIClient.Configuration(baseURL: baseURL, delegate: TMDBClientDelegate(apiKey: apiKey))
        resolver.register(name: .TMDBApiClient) { APIClient(configuration: configuration) }
        resolver.register { MovieNetworkingService() }.implements(MovieServiceProtocol.self)
        resolver.register { MovieSearchViewModel() }.implements(MovieSearchViewModeling.self)
    }
    public init() {}
}
