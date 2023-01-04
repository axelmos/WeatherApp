//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import Foundation

final class WeatherService : ApiService {
    
    func getCurrentWeather(lat: String, lon: String, completion: @escaping (WeatherResult) -> Void, failure: @escaping (String) -> Void) {
        
        let params = WeatherApiParameters(lat: lat, lon: lon, appid: Constants.Services.apiKey, units: "metric", lang: "es")
        let apiParameters = ApiRequestParameters(parameters: params)
        
        let request = ApiRequest(path: .home, method: .get, parameters: apiParameters)
        
        self.request(request, completion: { (response: WeatherResult) in
            completion(response)
        }, failure: { error in
            failure(error.message)
        })
    }
    
}
