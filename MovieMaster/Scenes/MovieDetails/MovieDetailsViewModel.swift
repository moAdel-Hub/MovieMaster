//
//  MovieDetailsViewModel.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 30/10/2024.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    
    @Published var movieDetails: MovieDetailsResponse?
    @Published var showAlert = false
    @Published var userError: LocalizedNetworkError?
    
    private var movieDetailsRepo: MovieDetailsRepositoryProtocol
    var movieID: Int {
        didSet {
            fetchMovieDetails()
        }
    }
    init(movieID: Int, movieDetailsRepo: MovieDetailsRepositoryProtocol = MovieDetailsRepository()) {
        self.movieDetailsRepo = movieDetailsRepo
        self.movieID = movieID
    }
    
    func fetchMovieDetails() {
        movieDetailsRepo.fetchMovieDetails(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.movieDetails = response
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    let error = error as? NetworkErrors
                    switch error {
                    case .urlRequestConstructionError:
                        self.userError = LocalizedNetworkError.urlRequestConstructionError
                    case .noInternet:
                        self.userError = LocalizedNetworkError.noInternet
                    case .failedToFetchData:
                        self.userError = LocalizedNetworkError.failedToFetchData
                    case .unknowError:
                        self.userError = LocalizedNetworkError.unknowError
                    case .none:
                        return
                    }
                }
            }
        }
    }
    
    func resetError() {
        userError = nil
        showAlert = false
    }
}
