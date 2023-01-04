//
//  Constants.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import Foundation

struct Constants {
    
    struct Services {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let iconURL = "https://openweathermap.org/img/wn/"
        static let weather = "weather"
        static let apiKey = "4714de5de3c3bec8d630c1cf6ec75a0e"
        static let encodingType = "application/json"
        static let contentType = "application/json;charset=utf-8"
    }
    
    struct Layout {
        struct Home {
            static let currentWeatherCellHeight = 200.0
            static let otherCellHeight = 80.0
        }
    }
}
