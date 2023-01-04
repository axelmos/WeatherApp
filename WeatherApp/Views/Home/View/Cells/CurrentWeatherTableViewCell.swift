//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 03/01/2023.
//

import UIKit
import SDWebImage

class CurrentWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var contentStackView: UIStackView?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var minMaxLabel: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
    
    func populate(model: WeatherResult) {
        activityIndicator?.stopAnimating()
        contentStackView?.isHidden = false
        locationLabel?.text = model.name
        tempLabel?.text = "\(Int(round(model.main.temp)))º"
        descriptionLabel?.text = model.weather[0].description
        minMaxLabel?.text = "Máx.: \(round(model.main.temp_max))º Mín.: \(round(model.main.temp_min))º"
        let iconURL = "\(Constants.Services.iconURL)\(model.weather[0].icon)@2x.png"
        if let url = URL.init(string: iconURL) {
            iconImageView?.sd_setImage(with: url)
        }
    }
}
