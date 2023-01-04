//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 02/01/2023.
//

import UIKit
import CoreLocation

class MainViewController: UITableViewController {
    
    lazy var weatherViewModel:WeatherProtocol = {
         return WeatherViewModel()
    }()
    lazy var otherLocationsViewModel:WeatherProtocol = {
         return WeatherViewModel()
    }()
    private var storedLocations: [Location] = [Location]()
    private var weatherResults: [WeatherResult] = [WeatherResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cells
        let cellNib = UINib(nibName: "CurrentWeatherTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CurrentWeatherTableViewCell")
        let otherNib = UINib(nibName: "OtherLocationTableViewCell", bundle: nil)
        tableView.register(otherNib, forCellReuseIdentifier: "OtherLocationTableViewCell")
        
        // Location
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: NSNotification.Name(rawValue: "LOCATION_UPDATED"), object: nil)
        LocationHelper.shared.getCurrentLocation()
        
        // Navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(onAddLocationButtonTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(onDeleteLocationsButtonTap))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weatherResults = [WeatherResult]()
        storedLocations = CoreDataManager.shared.getStoredLocations()
        
        for location in storedLocations {
            otherLocationsViewModel.getWeather(lat: location.lat, lon: location.lon) { [weak self] in
                if let result = self?.otherLocationsViewModel.weatherResult {
                    self?.weatherResults.append(contentsOf: result)
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                }
            } failure: { error in
                print(error)
            }

        }
    }
    
    // MARK: - Class methods
    
    @objc private func onAddLocationButtonTap() {
        performSegue(withIdentifier: "showMapSegue", sender: self)
    }
    
    @objc private func onDeleteLocationsButtonTap() {
        if CoreDataManager.shared.deleteAllLocations() {
            storedLocations = [Location]()
            weatherResults = [WeatherResult]()
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
    }
    
    @objc private func locationUpdated(notification: Notification) {
        guard let location = notification.object as? CLLocation else {
            return
        }
        weatherViewModel.getWeather(lat: String(location.coordinate.latitude), lon: String(location.coordinate.longitude)) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } failure: { error in
            print(error)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : weatherResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath) as? CurrentWeatherTableViewCell {
                if weatherViewModel.weatherResult.count > 0 {
                    cell.populate(model: weatherViewModel.weatherResult[0])
                }
                cell.selectionStyle = .none
                return cell
            }
        } else {
            if let otherCell = tableView.dequeueReusableCell(withIdentifier: "OtherLocationTableViewCell", for: indexPath) as? OtherLocationTableViewCell {
                if weatherResults.count > 0 {
                    otherCell.populate(model: weatherResults[indexPath.row])
                }
                otherCell.selectionStyle = .none
                return otherCell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ?  Constants.Layout.Home.currentWeatherCellHeight : Constants.Layout.Home.otherCellHeight
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Not available in this version")
    }
}

