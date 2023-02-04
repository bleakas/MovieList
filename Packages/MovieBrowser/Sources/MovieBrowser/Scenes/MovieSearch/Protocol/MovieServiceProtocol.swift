//
//  MovieServiceProtocol.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import struct TMDBClient.MovieDetails

public protocol MovieServiceProtocol: AnyObject {
    func getPopularMovies(page: Int) async throws -> [MovieDetails]
    func searchMovies(query: String, page: Int) async throws -> [MovieDetails]
}
