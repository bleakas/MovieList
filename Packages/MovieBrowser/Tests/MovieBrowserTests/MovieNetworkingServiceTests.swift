//
//  MovieNetworkingServiceTests.swift
//
//
//  Created by Pavel Shutkou on 03.02.23.
//

import XCTest
import Get
import Mocker
import TMDBClient
import MovieBrowser
import Resolver
import Utilities

final class MovieNetworkingServiceTests: XCTestCase {
    private var client: APIClient!
    private let baseURLString = "https://api.themoviedb.org/3"
    private var movieListURL: URL {
        URL(string: "\(baseURLString)/movie/popular")!
    }
    private var movieSearchURL: URL {
        URL(string: "\(baseURLString)/search/movie")!
    }

    override func setUp() {
        super.setUp()
        client = APIClient(baseURL: URL(string: baseURLString)) {
            $0.sessionConfiguration.protocolClasses = [MockingURLProtocol.self]
            $0.sessionConfiguration.urlCache = nil
            $0.delegate = TMDBClientDelegate(apiKey: "1")
        }
        Resolver.register(name: .TMDBApiClient) {
            self.client
        }
    }

    func testReturnsExpectedMovie() async throws {
        let netowrkingClient = MovieNetworkingService()
        // Mock data
        let movieData = try JSONEncoder().encode(MovieDetails(id: 1, title: "title", overview: ""))
        let movieList = MovieList(page: 1, results: [MovieList.Result(id: 1)], totalPages: 1)
        let movieListData = try JSONEncoder().encode(movieList)
        // Requests mocking
        let movieURL = URL(string: "\(baseURLString)/movie/1")!
        Mock(url: movieURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieData])
        .register()
        Mock(url: movieListURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieListData])
        .register()
        Mock(url: movieSearchURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieListData])
        .register()
        // retrieve movies
        let popularMovies = try await netowrkingClient.getPopularMovies(page: 1)
        let searchMovies = try await netowrkingClient.searchMovies(query: "1", page: 1)
        // check if we got movie with id 1
        XCTAssertEqual(popularMovies[0].id, 1)
        XCTAssertEqual(searchMovies[0].id, 1)
    }

    func testGetMovieReturnsTMDBError() async throws {
        let netowrkingClient = MovieNetworkingService()
        // Mock data
        let errorData = try JSONEncoder().encode(TMDBError(statusMessage: "error", statusCode: 401))
        let movieList = MovieList(page: 1, results: [MovieList.Result(id: 1)], totalPages: 1)
        let movieListData = try JSONEncoder().encode(movieList)
        // Requests mocking
        let movieURL = URL(string: "\(baseURLString)/movie/1")!
        Mock(url: movieURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 401,
             data: [.get: errorData])
        .register()
        Mock(url: movieListURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieListData])
        .register()
        Mock(url: movieSearchURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieListData])
        .register()
        // Check if methods raise our mocked error
        do {
            try _ = await netowrkingClient.getPopularMovies(page: 1)
        } catch {
            XCTAssertTrue(error is TMDBError)
            do {
                try _ = await netowrkingClient.searchMovies(query: "1", page: 1)
            } catch {
                XCTAssertTrue(error is TMDBError)
                return
            }
            XCTFail("No exception raised searchMovies")
        }
        XCTFail("No exception raised popularMovies")
    }

    func testGetMovieListReturnsTMDBError() async throws {
        let netowrkingClient = MovieNetworkingService()
        // Mock data
        let movieData = try JSONEncoder().encode(MovieDetails(id: 1, title: "title", overview: ""))
        let errorData = try JSONEncoder().encode(TMDBError(statusMessage: "error", statusCode: 401))
        // Requests mocking
        let movieURL = URL(string: "\(baseURLString)/movie/1")!
        Mock(url: movieURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieData])
        .register()
        Mock(url: movieListURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 401,
             data: [.get: errorData])
        .register()
        Mock(url: movieSearchURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 401,
             data: [.get: errorData])
        .register()
        // Check if methods raise our mocked error
        do {
            try _ = await netowrkingClient.getPopularMovies(page: 1)
        } catch {
            XCTAssertTrue(error is TMDBError)
            do {
                try _ = await netowrkingClient.searchMovies(query: "1", page: 1)
            } catch {
                XCTAssertTrue(error is TMDBError)
                return
            }
            XCTFail("No exception raised searchMovies")
        }
        XCTFail("No exception raised popularMovies")
    }

    func testIncorrectDataFromResponse() async throws {
        let netowrkingClient = MovieNetworkingService()
        // Mock data
        let movieList = MovieList(page: 1, results: [MovieList.Result(id: 1)], totalPages: 1)
        let movieListData = try JSONEncoder().encode(movieList)
        // Requests mocking
        let movieURL = URL(string: "\(baseURLString)/movie/1")!
        Mock(url: movieURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: Data()])
        .register()
        Mock(url: movieListURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: Data()])
        .register()
        Mock(url: movieSearchURL,
             ignoreQuery: true,
             dataType: .json,
             statusCode: 200,
             data: [.get: movieListData])
        .register()
        // Check if methods raise decoding error
        do {
            try _ = await netowrkingClient.getPopularMovies(page: 1)
        } catch {
            XCTAssertTrue(error is DecodingError)
            do {
                try _ = await netowrkingClient.searchMovies(query: "1", page: 1)
            } catch {
                let error2 = error
                XCTAssertTrue(error is DecodingError)
                return
            }
            XCTFail("No exception raised searchMovies")
        }
        XCTFail("No exception raised popularMovies")
    }
}
