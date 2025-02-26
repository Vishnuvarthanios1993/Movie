//
//  FavoriteMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Vishnuvarthan on 26/2/25.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}

extension FavoriteMovie : Identifiable {

}
