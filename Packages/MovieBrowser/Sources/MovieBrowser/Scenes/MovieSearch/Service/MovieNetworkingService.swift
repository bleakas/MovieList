//
//  MovieNetworkingService.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Resolver
import Utilities
import TMDBClient
import Get

public final class MovieNetworkingService {
    @Injected(name: .TMDBApiClient) private var apiClient: APIClient
    public init() {}
}

extension MovieNetworkingService: MovieServiceProtocol {
    public func getPopularMovies(page: Int) async throws -> [MovieDetails] {
        return []
    }

    public func searchMovies(query: String, page: Int) async throws -> [MovieDetails] {
        return []
    }
}
