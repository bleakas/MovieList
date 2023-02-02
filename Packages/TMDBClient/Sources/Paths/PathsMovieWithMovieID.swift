// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension Paths.Movie {
    public func movieID(_ movieID: Int) -> WithMovieID {
        WithMovieID(path: "\(path)/\(movieID)")
    }

    public struct WithMovieID {
        /// Path: `/movie/{movieId}`
        public let path: String

        /// Find movie by ID
        ///
        /// Returns movie details
        public func get(appendToResponse: AppendToResponse? = nil, language: String? = nil) -> Request<TMDBClient.MovieDetails> {
            Request(method: "GET", url: path, query: makeGetQuery(appendToResponse, language), id: "getMovieDetailsById")
        }

        private func makeGetQuery(_ appendToResponse: AppendToResponse?, _ language: String?) -> [(String, String?)] {
            let encoder = URLQueryEncoder()
            encoder.encode(appendToResponse, forKey: "append_to_response")
            encoder.encode(language, forKey: "language")
            return encoder.items
        }

        public enum AppendToResponse: String, Codable, CaseIterable {
            case credits
        }
    }
}
