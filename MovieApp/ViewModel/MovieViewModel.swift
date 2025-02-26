//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Vishnuvarthan on 26/2/25.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchDataByText = [Movie]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""
    @Published var selectedMovie: Movie?

    private var cancellables = Set<AnyCancellable>()
    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
        fetchMovies()
    }

    func fetchMovies() {
        isLoading = true
        movieService.fetchMovies()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.searchDataChange()
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(movie: Movie) {
        if FavoritesManager.shared.isFavorite(movie: movie) {
            FavoritesManager.shared.removeFavorite(movie: movie)
        } else {
            FavoritesManager.shared.addFavorite(movie: movie)
        }
        objectWillChange.send()
    }

    func isFavorite(movie: Movie) -> Bool {
        return FavoritesManager.shared.isFavorite(movie: movie)
    }

    private func searchDataChange() {
        $searchQuery
            .sink { searchText in
                self.getSearchDataByText(searchText)
            }
            .store(in: &cancellables)
    }
    
    func getSearchDataByText(_ text: String) {
        searchDataByText = movies.filter { $0.title.contains(text) }
        if searchDataByText.count == 0 {
            searchDataByText = movies
        }
    }

}
