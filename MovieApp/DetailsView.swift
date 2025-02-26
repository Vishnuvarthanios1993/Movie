//
//  DetailsView.swift
//  MovieApp
//
//  Created by Vishnuvarthan on 26/2/25.
//

import SwiftUI
import CoreData

struct DetailsView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .scaledToFit()
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
                
                Text(movie.title)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                Text("Release Date: \(movie.releaseDate ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Text(movie.overview)
                    .font(.body)
                    .padding()
            }
        }
        .navigationTitle("Movie Details")
    }
}
