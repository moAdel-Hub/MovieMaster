//
//  CoreDataManager.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import Foundation
import CoreData

protocol DataBaseProtocol {
    func save(object: NSManagedObject)
    func fetchMovies(with request: NSFetchRequest<PopularMovieResponse>) -> [PopularMovieResponse]?
    func fetchMovieDetails(with request: NSFetchRequest<MovieDetailsResponse>) -> [MovieDetailsResponse]?
    func clearCachedMovies()
}


final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: AppConstants.CoreDataModelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "\(AppConstants.CoreDataModelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }

        return persistentStoreCoordinator
    }()
}

extension CoreDataManager: DataBaseProtocol {
    func save(object: NSManagedObject) {
        if managedObjectContext.hasChanges {
            managedObjectContext.perform { [weak self] in
                guard let self else { return }
                self.managedObjectContext.insert(object)
                try? self.managedObjectContext.save()
            }
        }
    }
    
    func fetchMovies(with request: NSFetchRequest<PopularMovieResponse>) -> [PopularMovieResponse]? {
        let objects = try? managedObjectContext.fetch(request)
        return objects
    }
    
    func fetchMovieDetails(with request: NSFetchRequest<MovieDetailsResponse>) -> [MovieDetailsResponse]? {
        let objects = try? managedObjectContext.fetch(request)
        return objects
    }
    
    func clearCachedMovies() {
        let entities = ["Movie", "PopularMovieResponse", "MovieDetailsResponse"]
        managedObjectContext.perform { [weak self] in
            guard let self else { return }
            for entity in entities {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                let _ = try? self.managedObjectContext.execute(deleteRequest)
                try? managedObjectContext.save()
            }
        }
    }
}
