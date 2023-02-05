//
//  MovieDetails+ImageURL.swift
//  
//
//  Created by Pavel Shutkou on 05.02.23.
//

import Foundation
import TMDBClient

extension MovieDetails {
    public var imageURL: URL? {
        if let posterPath {
            return URL(string: TMDBUrlConstants.imageBaseURL + posterPath)
        }
        return nil
    }
}
