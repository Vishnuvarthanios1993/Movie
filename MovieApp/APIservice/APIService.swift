//
//  APIService.swift
//  MovieApp
//
//  Created by Vishnuvarthan on 26/2/25.
//

import SwiftUI

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchMovies() -> AnyPublisher<[Movie], Error>
}

class MovieService: MovieServiceProtocol {
    private let apiKey = "1ea96f7562cdeed5ef4cdc609191ff0c"
    private let baseURL = "https://api.themoviedb.org/3/discover/movie"
    
    func fetchMovies() -> AnyPublisher<[Movie], Error> {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
