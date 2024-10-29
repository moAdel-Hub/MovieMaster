//
//  PopularMovieResponse+CoreDataClass.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 28/10/2024.
//
//

import Foundation
import CoreData

@objc(PopularMovieResponse)
public class PopularMovieResponse: NSManagedObject, Codable {
    
    public required convenience init(from decoder: any Decoder) throws {
        let context = CoreDataManager.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "PopularMovieResponse", in: context)!
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = Int64(try container.decode(Int.self, forKey: .page))
        totalPages = Int64(try container.decode(Int.self, forKey: .totalPages))
        lastUpdateDate = Date()
        movies = NSSet(array: try container.decode([Movie].self, forKey: .movies))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(totalPages, forKey: .totalPages)
        let moviesArray = movies?.allObjects as? [Movie]
        try container.encode(moviesArray, forKey: .movies)
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
        
    }

}
