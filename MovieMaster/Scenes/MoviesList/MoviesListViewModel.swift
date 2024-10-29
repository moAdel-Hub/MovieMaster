//
//  MoviesListViewModel.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 29/10/2024.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var userError: LocalizedNetworkError?
    @Published var showAlert = false
    
    private var moviesRepository: MoviesListRepositoryProtocol
    
    var canLoadMore = true
    var totalPages = 1
    var page = 1
    
    init(moviesRepository: MoviesListRepositoryProtocol = MoviesListRepository()) {
        self.moviesRepository = moviesRepository
        fetchMovies()
    }
    
    func fetchMovies() {
        moviesRepository.fetchMoviesList(page: page) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let movies = response.movies?.allObjects as? [Movie] else { return }
                    self.totalPages = Int(response.totalPages)
                    self.movies.append(contentsOf: movies)
                    if self.totalPages > self.page { self.canLoadMore = true }
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
    
    func loadMore() {
        if page == totalPages {
            canLoadMore = false
            return
        }
        page += 1
        fetchMovies()
    }
    
    func resetError() {
        userError = nil
        showAlert = false
    }
    
}
