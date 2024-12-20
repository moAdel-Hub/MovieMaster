//
//  AppConstants.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import Foundation

enum AppConstants {
    static let CoreDataModelName = "MovieMasterDB"
}

enum APIConstant {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let apiKey = "3d5a4573afd4b6784d5665682f748b40"
    static let imageBaseURL = "https://image.tmdb.org/t/p/original/"
    
    enum Path {
        static let popularMoviePath = "/popular"
    }
    
    static let apiHeaders = ["accept": "application/json"]
}
