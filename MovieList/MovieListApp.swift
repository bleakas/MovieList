//
//  MovieListApp.swift
//  MovieList
//
//  Created by Pavel Shutkou on 28.01.23.
//

import SwiftUI
import MovieBrowser
import Kingfisher

@main
struct MovieListApp: App {
    var body: some Scene {
        WindowGroup {
            MovieSearchView()
        }
    }

    init() {
        configureKingfisher()
    }
}

// MARK: - configure Kingfisher

extension MovieListApp {
    private func configureKingfisher() {
        let cache = ImageCache.default
        let maxSize = 1000 * 1024 * 10
        cache.diskStorage.config.sizeLimit = UInt(maxSize)
        cache.memoryStorage.config.totalCostLimit = maxSize
    }
}
