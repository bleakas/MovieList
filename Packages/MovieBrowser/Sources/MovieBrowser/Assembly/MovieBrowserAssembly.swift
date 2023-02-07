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
        let baseURL = URL(string: TMDBUrlConstants.baseURLString)
        let apiKey = TMDBUrlConstants.apiKey
        let configuration = APIClient.Configuration(baseURL: baseURL, delegate: TMDBClientDelegate(apiKey: apiKey))
        resolver.register(name: .TMDBApiClient) { APIClient(configuration: configuration) }
        resolver.register { MovieNetworkingService() }.implements(MovieServiceProtocol.self)
        resolver.register {
            MovieSearchViewModel(maxPage: TMDBUrlConstants.maxPages)
        }.implements(MovieSearchViewModeling.self)
        resolver.register { (_, args) in
            MovieDetailViewModel(movie: args())
        }.implements(MovieDetailViewModeling.self)
    }
    public init() {}
}
