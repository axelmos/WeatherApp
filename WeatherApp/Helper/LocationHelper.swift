//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 03/01/2023.
//

import Foundation
import CoreLocation
import UIKit

class LocationHelper: NSObject, CLLocationManagerDelegate {
    var isAuthorized: Bool {
        return locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse
    }
    private var locationManager = CLLocationManager()
    static let shared = LocationHelper()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    @discardableResult func getCurrentLocation() -> Bool {
        guard isAuthorized else {
            locationManager.requestAlwaysAuthorization()
            return false
        }
        locationManager.requestLocation()
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LOCATION_UPDATED"), object: location, userInfo: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("CLLocationManager - didFailWithError")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            print("Need to grant Location permissions")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            print("Need to grant Location permissions")
        }
    }
}
