//
//  MovieSearchViewModelTests.swift
//  
//
//  Created by Pavel Shutkou on 07.02.23.
//

import Foundation
import XCTest
import TMDBClient
import Resolver
import MovieBrowser

final class MovieSearchViewModelTests: XCTestCase {
    
    @MainActor func testRetrieveMovies() {
        let movieService = MovieServiceMock()
        let items = [MovieDetails(id: 1, title: "", overview: "")]
        movieService.popularMovies = items
        movieService.searchMovies = items
        injectMovieService(movieService)
        let viewModel = MovieSearchViewModel(maxPage: 500)
        viewModel.loadMore()
        viewModel.query = "1"
        viewModel.loadMore()
        waitABit()
        XCTAssertEqual(viewModel.searchMovies, items)
        XCTAssertEqual(viewModel.popularMovies, items)
        XCTAssertEqual(viewModel.popularListState, .loaded)
        XCTAssertEqual(viewModel.searchListState, .loaded)
    }
    
    @MainActor func testRetrieveNothing() {
        let movieService = MovieServiceMock()
        injectMovieService(movieService)
        let viewModel = MovieSearchViewModel(maxPage: 500)
        viewModel.loadMore()
        viewModel.query = "1"
        viewModel.loadMore()
        waitABit()
        XCTAssertEqual(viewModel.searchMovies, [])
        XCTAssertEqual(viewModel.popularMovies, [])
        XCTAssertEqual(viewModel.searchListState, .empty)
    }
    
    @MainActor func testRefresh() {
        let movieService = MovieServiceMock()
        let items = [MovieDetails(id: 1, title: "", overview: "")]
        injectMovieService(movieService)
        let viewModel = MovieSearchViewModel(maxPage: 500)
        viewModel.loadMore()
        viewModel.query = "1"
        viewModel.loadMore()
        waitABit()
        movieService.popularMovies = items
        movieService.searchMovies = items
        viewModel.refresh()
        waitABit()
        XCTAssertEqual(viewModel.searchMovies, items)
        XCTAssertEqual(viewModel.popularMovies, [])
        XCTAssertEqual(viewModel.popularListState, .loaded)
        XCTAssertEqual(viewModel.searchListState, .loaded)
    }
    
    @MainActor func testRetrieveError() {
        let movieService = MovieServiceMock()
        let error = TMDBError()
        movieService.getPopularMoviesError = error
        movieService.searchMoviesError = error
        injectMovieService(movieService)
        let viewModel = MovieSearchViewModel(maxPage: 500)
        viewModel.loadMore()
        viewModel.query = "1"
        viewModel.loadMore()
        waitABit()
        XCTAssertEqual(viewModel.searchMovies, [])
        XCTAssertEqual(viewModel.popularMovies, [])
        XCTAssertEqual(viewModel.popularListState, .error)
        XCTAssertEqual(viewModel.searchListState, .error)
    }
    
    private func injectMovieService(_ service: MovieServiceMock) {
        Resolver.main.register { service }.implements(MovieServiceProtocol.self)
    }
    
    private func waitABit() {
        let expectation = XCTestExpectation(description: "Delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
        
        
}
