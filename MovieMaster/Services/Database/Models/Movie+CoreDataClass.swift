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
public class Movie: NSManagedObject, Decodable {

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
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
        case title
        
    }
}
