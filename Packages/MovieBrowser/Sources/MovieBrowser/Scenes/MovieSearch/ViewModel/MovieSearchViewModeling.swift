//
//  MovieSearchViewModeling.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Combine
import struct TMDBClient.MovieDetails

open class MovieSearchViewModeling: ObservableObject {
    @Published var query: String = ""
    @MainActor @Published var popularMovies: [MovieDetails] = []
    @MainActor @Published var searchMovies: [MovieDetails] = []
    @MainActor @Published var popularListState = ListState.initialLoading
    @MainActor @Published var searchListState = ListState.initialLoading

    func loadMore() {}
    func refresh() {}

    enum ListState {
        case loaded
        case initialLoading
        case additionalLoading
        case error(_ error: Error)
        case empty
    }
}
