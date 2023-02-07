//
//  MovieDetails+Helpers.swift
//  
//
//  Created by Pavel Shutkou on 05.02.23.
//

import Foundation
import TMDBClient

// MARK: - rating descrtipton
extension MovieDetails {
    public var ratingDescription: String {
        String(format: "%.1f", voteAverage ?? 0)
    }
}

// MARK: - genres descrtipton
extension MovieDetails {
    public var genresDescription: String {
        let genreNames = (genres ?? []).map {
            $0.name
        }
        return genreNames.joined(separator: ", ")
    }
}

// MARK: - cast descrtipton
extension MovieDetails {
    public var castDescription: String {
        let items = (credits?.cast ?? []).map {
            $0.name
        }
        return items.joined(separator: ", ")
    }
}

// MARK: - image URL helper
extension MovieDetails {
    public var imageURL: URL? {
        if let posterPath {
            return URL(string: TMDBUrlConstants.imageBaseURL + posterPath)
        }
        return nil
    }
}

// MARK: - MovieDetails + Hashable
extension MovieDetails: Hashable {
    public static func == (lhs: TMDBClient.MovieDetails, rhs: TMDBClient.MovieDetails) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
       hasher.combine(id)
     }
}
