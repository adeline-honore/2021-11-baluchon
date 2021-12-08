//
//  WeatherViewController.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Properties
    private var weatherView: WeatherView!
    private var weatherService = WeatherService()
    
    // MARK: - Override
    
    override func loadView() {
        super.loadView()
        weatherView = view as? WeatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeatherInformations()
    }
    
    // MARK: - Methods
    
    private func showWeatherInformations() {
        
        weatherService.getData { result in
            switch result {
            case .success(let weather):
                self.update(weatherDecode: weather)
            case .failure:
                self.errorMessage(element: .network)
            }
        }
    }
    
    private func update(weatherDecode: WeatherStructure) {
        DispatchQueue.main.async {
            //let city = weatherDecode.name
            
            self.weatherView.localWeatherDescription.text = weatherDecode.weather.first?.description
            
            self.weatherView.localWeatherTemperature.text = String(self.fahrenheitToCelsius(fahrenheit: weatherDecode.main.temp))
            
            self.weatherView.localWeatherImage.image = UIImage(named: weatherDecode.weather.first?.icon ?? "logo")
        }
    }
    
    private func fahrenheitToCelsius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32)/1.8
    }
}
