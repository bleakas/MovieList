//
//  MovieSearchViewModel.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import Foundation
import Combine
import Resolver

final public class MovieSearchViewModel: MovieSearchViewModeling {
    @Injected private var movieService: MovieServiceProtocol
    private var popularMoviesPage = 1
    private var searchMoviesPage = 1
    // max page after additional loading is disabled
    private let maxPage: Int
    private var cancellables = Set<AnyCancellable>()

    public init(maxPage: Int) {
        self.maxPage = maxPage
        super.init()
        bindQuery()
    }

    public override func loadMore() {
        if query.isEmpty,
           popularMoviesPage >= maxPage {
            return
        } else if !query.isEmpty,
                  searchMoviesPage >= maxPage {
            return
        }
        if query.isEmpty {
            Task {
                do {
                    try await loadPopular()
                } catch {
                    print(error.localizedDescription)
                    await MainActor.run { [weak self] in
                        self?.popularListState = .error
                    }
                }
            }
        } else {
            Task {
                do {
                    try await searchMovies()
                } catch {
                    print(error.localizedDescription)
                    await MainActor.run { [weak self] in
                        self?.searchListState = .error
                    }
                }
            }
        }
    }

    public override func refresh() {
        Task { [weak self] in
            await MainActor.run { [weak self] in
                guard let self else { return }
                if self.query.isEmpty {
                    self.popularMoviesPage = 1
                    self.popularMovies.removeAll()
                } else {
                    self.searchMoviesPage = 1
                    self.searchMovies.removeAll()
                }
                self.loadMore()
            }
        }
    }

    private func loadPopular() async throws {
        await MainActor.run { [weak self] in
            self?.popularListState = self?.popularMoviesPage == 1 ? .initialLoading : .additionalLoading
        }
        var movies = try await movieService.getPopularMovies(page: popularMoviesPage)
        for movie in movies {
            if await popularMovies.contains(movie),
               let index = movies.firstIndex(of: movie) {
                movies.remove(at: index)
            }
        }
        let immutableMovies = movies
        await MainActor.run { [weak self] in
            if immutableMovies.isEmpty {
                self?.popularMoviesPage = self?.maxPage ?? 500
            } else {
                self?.popularMoviesPage += 1
                self?.popularMovies.append(contentsOf: immutableMovies)
            }
            self?.popularListState = .loaded
        }
    }

    private func searchMovies() async throws {
        if searchMoviesPage != 1 {
            await MainActor.run { [weak self] in
                self?.searchListState = .additionalLoading
            }
        }
        var movies = try await movieService.searchMovies(query: query, page: searchMoviesPage)
        for movie in movies {
            if await searchMovies.contains(movie),
               let index = movies.firstIndex(of: movie) {
                movies.remove(at: index)
            }
        }
        let immutableMovies = movies
        await MainActor.run { [weak self] in
            if immutableMovies.isEmpty {
                self?.searchMoviesPage = self?.maxPage ?? 500
            } else {
                self?.searchMoviesPage += 1
                self?.searchMovies.append(contentsOf: immutableMovies)
            }
            self?.searchListState = searchMovies.isEmpty ? .empty : .loaded
        }
    }

    // MARK: - listen to searchField text updates
    private func bindQuery() {
        $query
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.loadMore()
            })
            .store(in: &cancellables)
        $query
            .sink(receiveValue: { [weak self] _ in
                self?.clearSearchMovies()
            })
            .store(in: &cancellables)
    }

    private func clearSearchMovies() {
        Task {
            await MainActor.run { [weak self] in
                self?.searchMovies = []
                self?.searchMoviesPage = 1
                self?.searchListState = .initialLoading
            }
        }
    }
}
