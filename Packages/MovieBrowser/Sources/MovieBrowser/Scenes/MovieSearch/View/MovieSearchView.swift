//
//  MovieSearchView.swift
//  
//
//  Created by Pavel Shutkou on 03.02.23.
//

import SwiftUI
import Resolver

public struct MovieSearchView: View {
    @StateObject var viewModel = Resolver.resolve(MovieSearchViewModeling.self)
    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.popularMovies, id: \.id) { movie in
                        Text(movie.title)
                    }
                }
            }
        }
        .navigationTitle("🍿Movies")
    }
    public init() {}
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
    init() {
        Resolver.register { MovieSearchViewModeling() }.implements(MovieSearchViewModeling.self)
    }
}
