//
//  Movie+CoreDataClass.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 28/10/2024.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Codable {

    public required convenience init(from decoder: any Decoder) throws {
        // Store to core data
        let context = CoreDataManager.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        self.init(entity: entity, insertInto: context)
        // Decoding json response
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Int64(try container.decode(Int.self, forKey: .id))
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        rating = try container.decode(Double.self, forKey: .rating)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(overview, forKey: .overview)
        try container.encode(title, forKey: .title)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(rating, forKey: .rating)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
        case title
        
    }
}
