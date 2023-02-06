//
//  MovieServiceMock.swift
//  
//
//  Created by Pavel Shutkou on 07.02.23.
//

import Foundation
import MovieBrowser
import TMDBClient

class MovieServiceMock: MovieServiceProtocol {
    var popularMovies: [MovieDetails] = []
    var searchMovies: [MovieDetails] = []
    var getPopularMoviesError: Error?
    var searchMoviesError: Error?

    func getPopularMovies(page: Int) async throws -> [MovieDetails] {
        if let error = getPopularMoviesError {
            throw error
        }
        return popularMovies
    }

    func searchMovies(query: String, page: Int) async throws -> [MovieDetails] {
        if let error = searchMoviesError {
            throw error
        }
        return searchMovies
    }
}
