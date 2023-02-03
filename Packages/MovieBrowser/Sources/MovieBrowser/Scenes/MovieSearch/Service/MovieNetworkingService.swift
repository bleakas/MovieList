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

final class MovieNetworkingService {
    @Injected(name: .TMDBApiClient) private var apiClient: APIClient
}

extension MovieNetworkingService: MovieServiceProtocol {
    func getPopularMovies(page: Int) async throws -> [MovieDetails] {
        return []
    }

    func searchMovies(query: String, page: Int) async throws -> [MovieDetails] {
        return []
    }
}
