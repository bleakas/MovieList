//
//  MovieSearchViewModeling.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Combine
import struct TMDBClient.MovieDetails

class MovieSearchViewModeling: ObservableObject {
    @Published var query: String = ""
    @Published var popularMovies: [MovieDetails] = []
    @Published var searchMovies: [MovieDetails] = []
    @Published var popularListState = ListState.initialLoading
    @Published var searchListState = ListState.initialLoading
    func loadMore() {}

    enum ListState {
        case loaded
        case initialLoading
        case additionalLoading
        case error(_ error: Error)
        case empty
    }
}
