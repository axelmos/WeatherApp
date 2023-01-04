//
//  OtherLocationTableViewCell.swift
//  WeatherApp
//
//  Created by Axel Mosiejko on 04/01/2023.
//

import UIKit

class OtherLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var containerView: UIView?
    
    func populate(model: WeatherResult) {
        activityIndicator?.stopAnimating()
        containerView?.isHidden = false
        locationLabel?.text = model.name
        tempLabel?.text = "\(Int(round(model.main.temp)))º"
        descriptionLabel?.text = model.weather[0].description
        let iconURL = "\(Constants.Services.iconURL)\(model.weather[0].icon)@2x.png"
        if let url = URL.init(string: iconURL) {
            iconImageView?.sd_setImage(with: url)
        }
    }
}
