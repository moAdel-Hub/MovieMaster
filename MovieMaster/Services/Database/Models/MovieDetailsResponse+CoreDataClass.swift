//
//  MovieDetailsResponse+CoreDataClass.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 30/10/2024.
//
//

import Foundation
import CoreData

@objc(MovieDetailsResponse)
public class MovieDetailsResponse: NSManagedObject, Codable {

    public required convenience init(from decoder: any Decoder) throws {
           let context = CoreDataManager.shared.managedObjectContext
           let entity = NSEntityDescription.entity(forEntityName: "MovieDetailsResponse", in: context)!
           self.init(entity: entity, insertInto: context)
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           id = Int64(try container.decode(Int.self, forKey: .id))
           backdrop = try container.decode(String.self, forKey: .backdrop)
           overview = try container.decode(String.self, forKey: .overview)
           releaseDate = try container.decode(String.self, forKey: .releaseDate)
           title = try container.decode(String.self, forKey: .title)
           tagline = try container.decode(String.self, forKey: .tagline)
           lastUpdateDate = Date()
       }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(backdrop, forKey: .backdrop)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(overview, forKey: .overview)
        try container.encode(title, forKey: .title)
        try container.encode(tagline, forKey: .tagline)
    }
       
       enum CodingKeys: String, CodingKey {
           case backdrop = "backdrop_path"
           case id, overview
           case releaseDate = "release_date"
           case tagline, title
       }
}
