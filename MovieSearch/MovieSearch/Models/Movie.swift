//
//  Movie.swift
//  MovieSearch
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation

struct TopLevelDictionary: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let overview: String
    let rating: Double
    let image: String?

    private enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case image = "poster_path"
        case title, overview
    }
}
