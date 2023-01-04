//
//  ApiError.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

struct ApiError: Error {
    var message:String
    var statusCode:String
    var details: [String]

}

extension ApiError: Decodable {
    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case statusCode = "code"
        case details = "details"
    }
}
