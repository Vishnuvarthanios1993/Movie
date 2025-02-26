//
//  MovieModel.swift
//  MovieApp
//
//  Created by Vishnuvarthan on 26/2/25.
//

import SwiftUI
import Combine

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let releaseDate: String?
    let posterPath: String?
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
