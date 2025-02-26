//
//  MockServiceTest.swift
//  MovieAppTests
//
//  Created by Vishnuvarthan on 26/2/25.
//

import Foundation
import Combine

final class MockMovieService: MovieServiceProtocol {
    func fetchMovies() -> AnyPublisher<[Movie], Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            let mockMovies = [
                Movie(id: 1, title: "Batman Begins", releaseDate: "2005-06-15", posterPath: nil, overview: ""),
                Movie(id: 2, title: "The Dark Knight", releaseDate: "2008-07-18", posterPath: nil, overview: "")
            ]
            return Just(mockMovies)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    var shouldFail: Bool
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    
}
