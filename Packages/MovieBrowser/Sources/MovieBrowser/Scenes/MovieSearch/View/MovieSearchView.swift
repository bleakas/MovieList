//
//  MovieSearchView.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import SwiftUI
import Resolver
import SharedResources
import struct TMDBClient.MovieDetails

public struct MovieSearchView: View {
    @InjectedObject var viewModel: MovieSearchViewModeling

    public var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    movieList(movies: $viewModel.popularMovies, state: $viewModel.popularListState)
                }
                .opacity(viewModel.query.isEmpty ? 1 : 0)
                .refreshable { viewModel.loadMore() }
                if !viewModel.query.isEmpty {
                    ScrollView {
                        movieList(movies: $viewModel.searchMovies, state: $viewModel.searchListState)
                    }
                    .refreshable { viewModel.loadMore() }
                    if case .initialLoading = viewModel.searchListState {
                        ProgressView()
                            .padding(.vertical, 10)
                            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                    }
                    if case .empty = viewModel.searchListState {
                        Text(R.string.localizable.noData())
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(R.color.highlightedForeground.color)
                    }
                }
            }
            .navigationDestination(for: MovieDetails.self) { movie in
                MovieDetailView(movie: movie)
            }
            .navigationTitle("🍿 " + R.string.localizable.movies())
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $viewModel.query,
                    placement: .navigationBarDrawer(displayMode: .always), prompt: R.string.localizable.search())
        .tint(R.color.highlightedForeground.color)
        .onAppear {
            viewModel.loadMore()
        }
    }

    private func movieList(movies: Binding<[MovieDetails]>,
                           state: Binding<MovieSearchViewModeling.ListState>) -> some View {
        return LazyVStack(spacing: 0) {
            ForEach(movies, id: \.id) { $movie in
                NavigationLink(value: movie) {
                    MovieListItemView(movie: movie)
                        .onAppear {
                            if movie == movies.wrappedValue.last {
                                viewModel.loadMore()
                            }
                        }
                }
            }
            if case .additionalLoading = state.wrappedValue {
                ProgressView()
                    .padding(.vertical, 10)
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }
        }
        .background(R.color.secondaryBackground.color)
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }

    public init() {}
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
