//
//  ContentView.swift
//  MovieApp
//
//  Created by Vishnuvarthan on 26/2/25.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Movies", text: $viewModel.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    List(viewModel.searchDataByText) { movie in
                        MovieRow(movie: movie)
                    }
                }
            }
            .navigationTitle("Movies")
        }
        .onAppear {
            viewModel.fetchMovies()
        }
    }
}

struct MovieRow: View {
    let movie: Movie
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(3)
                    .foregroundColor(.gray)
            }
            
            Spacer()

            Button(action: { viewModel.toggleFavorite(movie: movie) }) {
                Image(systemName: viewModel.isFavorite(movie: movie) ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isFavorite(movie: movie) ? .red : .gray)
            }
        }
        .background(
            NavigationLink("", destination: DetailsView(movie: movie))
                .opacity(0)
        )

        .padding(.vertical, 5)
    }
}
