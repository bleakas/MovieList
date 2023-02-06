//
//  MovieDetailView.swift
//  
//
//  Created by Pavel Shutkou on 29.01.23.
//

import SwiftUI
import struct TMDBClient.MovieDetails
import SharedResources
import Kingfisher
import Resolver

public struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModeling
    public var body: some View {
        ScrollView {
            if viewModel.movie.posterPath != nil {
                GeometryReader { geometry in // Implement Parallax Scrolling Header
                    VStack {
                        if geometry.frame(in: .global).minY <= 0 {
                            KFImage(viewModel.movie.imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(y: geometry.frame(in: .global).minY/9)
                                .clipped()
                        } else {
                            KFImage(viewModel.movie.imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.width * 1.3)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(R.string.localizable.overview())
                    .font(.system(size: 23, weight: .bold, design: .default))
                    .foregroundColor(R.color.titleForeground.color)
                    .multilineTextAlignment(.leading)
                Text(viewModel.movie.overview)
                    .font(.system(size: 15, weight: .light, design: .default))
                    .foregroundColor(R.color.subtitleForeground.color)
                    .multilineTextAlignment(.leading)
                if !viewModel.movie.castDescription.isEmpty {
                    Text(R.string.localizable.cast())
                        .font(.system(size: 23, weight: .bold, design: .default))
                        .foregroundColor(R.color.titleForeground.color)
                        .multilineTextAlignment(.leading)
                    Text(viewModel.movie.castDescription)
                        .font(.system(size: 15, weight: .light, design: .default))
                        .foregroundColor(R.color.subtitleForeground.color)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 20)
        }
        .edgesIgnoringSafeArea(viewModel.movie.posterPath == nil ? .horizontal : Edge.Set())
        .safeAreaInset(edge: .top) {
            Color.clear
                .frame(height: 0)
                .background(.bar)
                .border(.black)
        }
                .navigationTitle(viewModel.movie.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text(viewModel.movie.ratingDescription + " 🏆")
                            .foregroundColor(R.color.subtitleForeground.color)
                            .font(.system(size: 15, weight: .regular, design: .default))
                    }
                }

    }
    public init(movie: MovieDetails) {
        self.viewModel = Resolver.resolve(args: movie)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieDetails(id: 1, title: "asdasd", overview: "asdasda"))
    }
}
