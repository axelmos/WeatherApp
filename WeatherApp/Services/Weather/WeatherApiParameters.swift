//
//  WeatherApiParameters.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import Foundation

struct WeatherApiParameters: ApiParametersProtocol {
    
    var lat: String
    var lon: String
    var appid: String
    var units: String
    var lang: String
     
    init(lat: String, lon: String, appid: String, units: String, lang: String) {
        self.lat = lat
        self.lon = lon
        self.appid = appid
        self.units = units
        self.lang = lang
    }
    
    func queryParams() -> ApiParameters {
        return ["lat": lat, "lon": lon, "appid": appid, "units": units, "lang": lang]
    }
}
