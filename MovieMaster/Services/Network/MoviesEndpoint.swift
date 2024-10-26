//
//  MoviesEndpoint.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import Foundation
import Moya

enum MoviesEndpoint {
    case popularMovie(page: Int)
    case movieDetails(movieID: Int)
}

extension MoviesEndpoint: TargetType {
    var baseURL: URL {
        guard let url  = URL(string: APIConstant.baseURL) else {
            fatalError("Invalid Base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .popularMovie(_):
            "/popular"
        case .movieDetails(let movieID):
            "/\(movieID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popularMovie(_), .movieDetails(_):
                .get
        }
    }
    
    var task: Moya.Task {
        var parameters: [String: Any] =  ["api_key": APIConstant.apiKey]
        switch self {
        case .popularMovie(let page):
            parameters["page"] = page
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .movieDetails(_):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return APIConstant.apiHeaders
    }
    
    
}
