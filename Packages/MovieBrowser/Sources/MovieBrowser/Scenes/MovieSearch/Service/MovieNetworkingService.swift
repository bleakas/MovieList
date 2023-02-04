//
//  MovieNetworkingService.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Foundation
import Resolver
import Utilities
import TMDBClient
import Get

public final class MovieNetworkingService {
    @Injected(name: .TMDBApiClient) private var apiClient: APIClient
    private let language = Locale.current.identifier
    public init() {}
}

extension MovieNetworkingService: MovieServiceProtocol {
    public func getPopularMovies(page: Int) async throws -> [MovieDetails] {
        let request = Paths.movie.popular.get(page: page, language: language)
        return try await extractMoviesFromMovieList(request: request)
    }

    public func searchMovies(query: String, page: Int) async throws -> [MovieDetails] {
        let parameters = Paths.Search.Movie.GetParameters(page: page, language: language, query: query)
        let request = Paths.search.movie.get(parameters: parameters)
        return try await extractMoviesFromMovieList(request: request)
    }

    private func extractMoviesFromMovieList(request: Request<TMDBClient.MovieList>) async throws -> [MovieDetails] {
        let popular = try await apiClient.send(request)
        let movieIDs = (popular.value.results ?? []).map {
            $0.id
        }
        return try await withThrowingTaskGroup(of: MovieDetails.self, returning: [MovieDetails].self) {
            [weak self] group in
            guard let self else { return [] }
            for id in movieIDs {
                group.addTask {
                    let request = Paths.movie.movieID(id).get(appendToResponse: .credits)
                    return try await self.apiClient.send(request).value
                }
            }
            var movies = [MovieDetails]()
            for try await item in group {
                movies.append(item)
            }
            return movies
        }
    }
}
