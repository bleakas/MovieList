//
//  MovieDetails+Genres.swift
//  
//
//  Created by Pavel Shutkou on 05.02.23.
//

import Foundation
import TMDBClient

extension MovieDetails {
    public var genresDescription: String {
        let genreNames = (genres ?? []).map {
            $0.name
        }
        return genreNames.joined(separator: ", ")
    }
}
