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
public class PopularMovieResponse: NSManagedObject, Decodable {
    
    public required convenience init(from decoder: any Decoder) throws {
        let context = CoreDataManager.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = Int64(try container.decode(Int.self, forKey: .page))
        totalPages = Int64(try container.decode(Int.self, forKey: .totalPages))
        movies = NSSet(array: try container.decode([Movie].self, forKey: .movies))
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
        
    }

}
