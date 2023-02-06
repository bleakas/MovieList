//
//  MovieSearchViewModeling.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Combine
import struct TMDBClient.MovieDetails

open class MovieSearchViewModeling: ObservableObject {
    @Published open var query: String = ""
    @MainActor @Published open var popularMovies: [MovieDetails] = []
    @MainActor @Published open var searchMovies: [MovieDetails] = []
    @MainActor @Published open var popularListState = ListState.initialLoading
    @MainActor @Published open var searchListState = ListState.initialLoading

    open func loadMore() {}
    open func refresh() {}

    public enum ListState {
        case loaded
        case initialLoading
        case additionalLoading
        case error(_ error: Error)
        case empty
    }
}
