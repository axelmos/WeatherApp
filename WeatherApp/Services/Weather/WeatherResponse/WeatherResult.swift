//
//  Weather.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import Foundation

struct WeatherResult: Decodable {
    var weather: [Weather]
    var main: Main
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case main
        case name
    }
}

struct Weather: Decodable {
    var main: String
    var description: String
    var icon: String
    
    private enum CodingKeys: String, CodingKey {
        case main
        case description
        case icon
    }
}

struct Main: Decodable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Float
    var humidity: Float
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure
        case humidity
    }
}
