//
//  MovieDetailsRepo.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 30/10/2024.
//

import Foundation
import Alamofire

protocol MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void)
}

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    let moviesNetworkService: MoviesNetworkManagerProtocol
    let movieDetailsDB: DataBaseProtocol
    private let cacheTimeout: TimeInterval = 4 * 60 * 60
    
    init(moviesNetworkService: MoviesNetworkManagerProtocol = MoviesNetworkManager(), movieDetailsDB: DataBaseProtocol = CoreDataManager.shared) {
        self.moviesNetworkService = moviesNetworkService
        self.movieDetailsDB = movieDetailsDB
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        
        if let movieDetails = fetchMovieDetailsFromDB(movieID: movieID), !movieDetails.isEmpty, let lastUpdate = movieDetails.first?.lastUpdateDate {
            if shouldUpdateDB(lastUpdated: lastUpdate) || !checkNetworkReachability() {
                completion(.success(movieDetails.first!))
                return
            } else {
                movieDetailsDB.clearCachedMovies()
            }
        }
        
        guard checkNetworkReachability() else {
            completion(.failure(NetworkErrors.noInternet))
            return
        }
        
        moviesNetworkService.fetchMovieDetails(id: movieID){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movieDetailsDB.save(object: response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchMovieDetailsFromDB(movieID: Int) -> [MovieDetailsResponse]? {
        let fetchRequest = MovieDetailsResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: movieID))
        let movies = movieDetailsDB.fetchMovieDetails(with: fetchRequest)
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
