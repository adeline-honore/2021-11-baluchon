//
//  CustomWeatherView.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 08/12/2021.
//

import UIKit

class CustomWeatherView: UIView {
   
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func configure(cityNameValue: String, temperatureValue: String, detailsValue: String, imageValue: String) {
        cityName.text = cityNameValue
        temperature.text = temperatureValue
        details.text = detailsValue
        image.image = UIImage(named: imageValue)
    }
}
