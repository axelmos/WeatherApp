//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import Foundation

class WeatherViewModel {
    var _weatherResult: [WeatherResult]?
    var service: WeatherService
    
    init(service: WeatherService = WeatherService()) {
        self.service = service
    }
}

extension WeatherViewModel: WeatherProtocol {
    var weatherResult: [WeatherResult] {
        return _weatherResult ?? []
    }
    
    func getWeather(lat: String, lon: String, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        service.getCurrentWeather(lat: lat, lon: lon) { [weak self] data in
            self?._weatherResult = [data]
            completion()
        } failure: { error in
            failure(error)
        }
    }
    
}
