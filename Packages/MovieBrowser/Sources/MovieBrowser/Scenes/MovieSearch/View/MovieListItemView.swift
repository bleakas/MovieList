//
//  MovieListItemView.swift
//  
//
//  Created by Pavel Shutkou on 05.02.23.
//

import SwiftUI
import struct TMDBClient.MovieDetails
import Utilities
import SharedResources

struct MovieListItemView: View {
    var movie: MovieDetails

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                AsyncImage(url: movie.imageURL(quality: .list)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ZStack {
                        Rectangle().foregroundColor(.gray)
                        if movie.posterPath == nil {
                            Text(R.string.localizable.noImage())
                                .font(.system(size: 12, weight: .light, design: .default))
                                .foregroundColor(R.color.highlightedForeground.color)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 60, height: 90)
                }
                .frame(width: 60, height: 90)
                VStack(alignment: .leading, spacing: 1) {
                    Text(movie.title)
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .foregroundColor(R.color.titleForeground.color)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Text(movie.genresDescription)
                        .font(.system(size: 12, weight: .light, design: .default))
                        .foregroundColor(R.color.subtitleForeground.color)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    HStack {
                        ProgressView(value: movie.voteAverage ?? 0, total: 10)
                            .tint(R.color.highlightedForeground.color)
                        Text(movie.ratingDescription)
                            .foregroundColor(R.color.subtitleForeground.color)
                            .font(.system(size: 15, weight: .regular, design: .default))
                    }
                }
                Image.chevronForward
                    .foregroundColor(R.color.subtitleForeground.color)
                    .padding(.trailing, 20)
            }
            Divider()
        }
    }
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItemView(movie: MovieDetails(id: 1, title: "title", overview: "text"))
    }
}
