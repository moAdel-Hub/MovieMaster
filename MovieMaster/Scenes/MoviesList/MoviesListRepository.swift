//
//  MoviesListRepository.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 29/10/2024.
//

import Foundation
import Alamofire

protocol MoviesListRepositoryProtocol {
    func fetchMoviesList(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> Void)
}

final class MoviesListRepository: MoviesListRepositoryProtocol {
    
    let moviesNetworkService: MoviesNetworkManagerProtocol
    let moviesDB: DataBaseProtocol
    private let cacheTimeout: TimeInterval = 4 * 60 * 60
    
    init(moviesNetworkService: MoviesNetworkManagerProtocol = MoviesNetworkManager(), moviesDB: DataBaseProtocol = CoreDataManager.shared) {
        self.moviesNetworkService = moviesNetworkService
        self.moviesDB = moviesDB
    }
    
    func fetchMoviesList(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> Void) {
        
        if let localStorage = fetchFromDB(page: page), !localStorage.isEmpty, let lastUpdate = localStorage.first?.lastUpdateDate {
            if shouldUpdateDB(lastUpdated: lastUpdate) || !checkNetworkReachability() {
                completion(.success(localStorage.first!))
                return
            } else {
                moviesDB.clearCachedMovies()
            }
        }
        
        guard checkNetworkReachability() else {
            completion(.failure(NetworkErrors.noInternet))
            return
        }
        
        moviesNetworkService.fetchPopularMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.moviesDB.save(object: movies)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchFromDB(page: Int) -> [PopularMovieResponse]? {
        let fetchRequest = PopularMovieResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "page == %d", page)
        let movies = moviesDB.fetchMovies(with: fetchRequest)
        return movies
    }
    
    private func shouldUpdateDB(lastUpdated: Date) -> Bool {
        let dif = Date().timeIntervalSince(lastUpdated)
        return dif < cacheTimeout
    }
    
    private func checkNetworkReachability() -> Bool {
        guard let reachability = NetworkReachabilityManager(), reachability.isReachable else {
            return false
        }
        return true
    }
}
