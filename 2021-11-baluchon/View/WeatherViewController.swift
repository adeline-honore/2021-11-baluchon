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
            
            self .weatherView.originWeatherView.configure(
                value1: weatherDecode.name,
                value2: self.kelvinToCelsius(kelvin: weatherDecode.main.temp),
                value3: weatherDecode.weather.first?.description ?? "no value",
                value4: weatherDecode.weather.first?.icon ?? "logo"
            )
        }
    }
    
    private func kelvinToCelsius(kelvin: Double) -> String {
        return String(format:"%.1f", (kelvin - 273.15))
    }
}
