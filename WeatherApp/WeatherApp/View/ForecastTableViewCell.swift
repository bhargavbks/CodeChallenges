//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Bhargav BKS on 08/07/2020.
//  Copyright © 2020 TTF. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var weatherImg: UIImageView!

    @IBOutlet weak var dateTime: UILabel!

    @IBOutlet weak var maxTemp: UILabel!

    @IBOutlet weak var minTemp: UILabel!

    @IBOutlet weak var feelsLikeTemp: UILabel!

    @IBOutlet weak var currentTemp: UILabel!

    @IBOutlet weak var humidity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    
    func configure(with data: ForecastCellDataModel) {
        dateTime.text = data.date
        currentTemp.text = data.currentTemp
        maxTemp.text = data.maxTemp
        minTemp.text = data.minTemp
        feelsLikeTemp.text = data.feelsLike
        humidity.text = data.humidity
        weatherImg.image = UIImage(named: data.weatherIcon)
    }
}
