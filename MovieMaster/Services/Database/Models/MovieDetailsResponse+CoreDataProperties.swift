//
//  MovieDetailsResponse+CoreDataProperties.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 30/10/2024.
//
//

import Foundation
import CoreData


extension MovieDetailsResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetailsResponse> {
        return NSFetchRequest<MovieDetailsResponse>(entityName: "MovieDetailsResponse")
    }

    @NSManaged public var backdrop: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastUpdateDate: Date?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?

}

extension MovieDetailsResponse : Identifiable {

}
