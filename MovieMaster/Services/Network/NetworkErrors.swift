//
//  NetworkErrors.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import Foundation

enum NetworkErrors: Error {
    case urlRequestConstructionError
    case noInternet
    case failedToFetchData
    case unknowError
}

enum LocalizedNetworkError: LocalizedError {
    case urlRequestConstructionError
    case noInternet
    case failedToFetchData
    case unknowError
    
    var errorDescription: String? {
        switch self {
        case .urlRequestConstructionError:
            AppStrings.ErrorDestination.urlRequestConstructionError
        case .noInternet:
            AppStrings.ErrorDestination.noInternet
        case .failedToFetchData:
            AppStrings.ErrorDestination.failedToFetchData
        case .unknowError:
            AppStrings.ErrorDestination.unKnowError
        }
    }
}
