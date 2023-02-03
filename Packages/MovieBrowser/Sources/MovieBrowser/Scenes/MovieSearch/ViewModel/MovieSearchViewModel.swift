//
//  MovieSearchViewModel.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Resolver

final class MovieSearchViewModel: MovieSearchViewModeling {
    @Injected private var movieService: MovieServiceProtocol
    private var popularMoviesPage = 1
    private var searchMoviesPage = 1
}
