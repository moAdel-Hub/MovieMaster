//
//  PopularMovieResponse+CoreDataProperties.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 28/10/2024.
//
//

import Foundation
import CoreData


extension PopularMovieResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PopularMovieResponse> {
        return NSFetchRequest<PopularMovieResponse>(entityName: "PopularMovieResponse")
    }

    @NSManaged public var lastUpdateDate: Date?
    @NSManaged public var page: Int64
    @NSManaged public var totalPages: Int64
    @NSManaged public var movies: NSSet?
}

extension PopularMovieResponse {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension PopularMovieResponse : Identifiable {

}
