//
//  MovieDetailViewModeling.swift
//  
//
//  Created by Pavel Shutkou on 07.02.23.
//

import Foundation
import Combine
import struct TMDBClient.MovieDetails

open class MovieDetailViewModeling: ObservableObject {
    @Published var movie: MovieDetails

    init(movie: MovieDetails) {
        self.movie = movie
    }
}
