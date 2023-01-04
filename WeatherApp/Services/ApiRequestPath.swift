//
//  ApiRequestPath.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

enum Enviroment {
   case dev
   case prod
}
 
var enviroment: Enviroment = .prod

enum ApiRequestPath {
    case home
    case detail
    
    var subPath: String {
        switch self {
        case .home: return Constants.Services.weather
        case .detail: return ""
        }
    }
    
    var basePath: String {
        if enviroment == .dev { return Constants.Services.baseURL }
        
        switch self {
        case .home: return Constants.Services.baseURL
        case .detail: return ""
        }
    }
}
