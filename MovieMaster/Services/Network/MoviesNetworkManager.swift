//
//  MoviesNetworkManager.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import Foundation
import Moya
import Alamofire

protocol MoviesNetworkManagerProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ())
    func fetchMovieDetails(id: Int, completion: @escaping (Result<Movie, Error>) -> ())
}


final class MoviesNetworkManager: MoviesNetworkManagerProtocol {
    
    private let dataProvider: MoyaProvider<MoviesEndpoint>
    
    init() {
        self.dataProvider = MoyaProvider<MoviesEndpoint>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    }
    
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ()) {
        dataProvider.request(.popularMovie(page: page)) { result in
            switch result {
            case .success(let result):
                do {
                    let popularMovies = try JSONDecoder().decode(PopularMovieResponse.self, from: result.data)
                    completion(.success(popularMovies))
                } catch {
                    completion(.failure(NetworkErrors.failedToFetchData))
                }
            case .failure(_):
                completion(.failure(NetworkErrors.failedToFetchData))
            }
        }
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Result<Movie, Error>) -> ()) {
        dataProvider.request(.movieDetails(movieID: id)) { result in
            switch result {
            case .success(let result):
                do {
                    let movieDetails = try JSONDecoder().decode(Movie.self, from: result.data)
                    completion(.success(movieDetails))
                } catch {
                    completion(.failure(NetworkErrors.failedToFetchData))
                }
            case .failure(_):
                completion(.failure(NetworkErrors.failedToFetchData))
            }
        }
    }
}
