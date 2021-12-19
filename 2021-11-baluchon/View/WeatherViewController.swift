//
//  WeatherViewController.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var originWeatherView: CustomWeatherView!
    @IBOutlet weak var destinyWeatherView: CustomWeatherView!
    
    private var weatherView: WeatherView!
    private var weatherService = WeatherService()
    
    private let originCity: String = "Paris"
    private let destinationCity: String = "Nantes"
    
    
    // MARK: - Override
    
    override func loadView() {
        super.loadView()
        weatherView = view as? WeatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeatherInformations(city: originCity, weatherView: originWeatherView)
        showWeatherInformations(city: destinationCity, weatherView: destinyWeatherView)
    }
    
    // MARK: - Methods
    
    private func showWeatherInformations(city: String, weatherView: CustomWeatherView) {
        
        weatherService.getData(city: city) { result in
            switch result {
            case .success(let weather):
                self.update(weatherDecode: weather, customView: weatherView)
            case .failure:
                self.errorMessage(element: .network)
            }
        }
    }
    
    private func update(weatherDecode: WeatherStructure, customView: CustomWeatherView) {
        DispatchQueue.main.async { 
            
            customView.configure(
                cityNameValue: weatherDecode.name,
                temperatureValue: self.kelvinToCelsius(kelvin: weatherDecode.main.temp),
                detailsValue: weatherDecode.weather.first?.description ?? "no value",
                imageValue: weatherDecode.weather.first?.icon ?? "logo"
            )
        }
    }
    
    private func kelvinToCelsius(kelvin: Double) -> String {
        return String(format:"%.1f", (kelvin - 273.15))
    }
}
