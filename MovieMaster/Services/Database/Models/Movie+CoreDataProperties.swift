//
//  Movie+CoreDataProperties.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 28/10/2024.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}

extension Movie : Identifiable {

}
