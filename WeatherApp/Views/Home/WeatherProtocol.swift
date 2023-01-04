//
//  WeatherProtocol.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import Foundation

protocol WeatherProtocol {
    var weatherResult: [WeatherResult] { get }
    
    func getWeather(lat: String, lon: String, completion: @escaping () -> (), failure: @escaping (String) -> ())
    
}
