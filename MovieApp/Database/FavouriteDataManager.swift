//
//  FavouriteDataManager.swift
//  MovieTask
//
//  Created by Vishnuvarthan on 26/2/25.
//

import CoreData

class FavoritesManager {
    static let shared = FavoritesManager()
    
    func addFavorite(movie: Movie) {
        let favorite = FavoriteMovie(context: CoreDataManager.shared.context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.overview = movie.overview
        favorite.posterPath = movie.posterPath
        CoreDataManager.shared.save()
    }

    func removeFavorite(movie: Movie) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)

        if let result = try? context.fetch(fetchRequest), let favorite = result.first {
            context.delete(favorite)
            CoreDataManager.shared.save()
        }
    }

    func isFavorite(movie: Movie) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)

        let result = try? CoreDataManager.shared.context.fetch(fetchRequest)
        return !(result?.isEmpty ?? true)
    }
}
