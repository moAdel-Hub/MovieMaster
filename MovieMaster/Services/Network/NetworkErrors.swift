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
}
