//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Vishnuvarthan on 26/2/25.
//

import XCTest
import Combine
@testable import MovieApp

final class MovieAppTests: XCTestCase {
    var viewModel: MovieViewModel!
    var mockMovieService: MockMovieService!
    var mockCoreDataHelper: MockCoreDataHelper!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockMovieService = MockMovieService()
        mockCoreDataHelper = MockCoreDataHelper()
        viewModel = MovieViewModel(movieService: mockMovieService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockMovieService = nil
        mockCoreDataHelper = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        let movies = [Movie(id: 1, title: "Movie 1", releaseDate: "2025", posterPath: nil, overview: "Test")]
        mockMovieService.movies = movies
        
        let expectation = XCTestExpectation(description: "Movies fetched successfully")
        
        viewModel.$movies
            .dropFirst()
            .sink { fetchedMovies in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovies()
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testToggleFavorite() {
        let movies = Movie(id: 1, title: "Movie 1", releaseDate: "2025", posterPath: nil, overview: "Test")
        XCTAssertFalse(viewModel.isFavorite(movie: movies))
        viewModel.toggleFavorite(movie: movies)
        XCTAssertTrue(viewModel.isFavorite(movie: movies))
        viewModel.toggleFavorite(movie: movies)
        XCTAssertFalse(viewModel.isFavorite(movie: movies))
    }
    
}

class MockMovieService: MovieService {
    var movies: [Movie] = []
    override func fetchMovies() -> AnyPublisher<[Movie], Error> {
        Just(movies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

    }
 }

class MockCoreDataHelper: FavoritesManager {
    private var storedMovies: [Movie] = []
    
    override func addFavorite(movie: Movie) {
        storedMovies.append(movie)
    }
    
    override func removeFavorite(movie: Movie) {
        storedMovies.removeAll { $0.id == movie.id }
    }
}
