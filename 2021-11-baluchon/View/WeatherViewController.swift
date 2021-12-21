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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var weatherService: WeatherServiceProtocol = WeatherService()
    
    private let originCity: String = "Paris"
    private let destinationCity: String = "Nantes"
    
    
    // MARK: - Override
    
    override func loadView() {
        super.loadView()
        let name = Notification.Name("WeatherLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(weatherLoaded), name: name, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWeatherInformations(city: originCity, weatherView: originWeatherView)
        showWeatherInformations(city: destinationCity, weatherView: destinyWeatherView)
    }
    
    // MARK: - Methods
    
    private func showWeatherInformations(city: String, weatherView: CustomWeatherView) {
        
        weatherView.isHidden = true
        activityIndicator.isHidden = false
        
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
        DispatchQueue.main.async { [weak self] in
            
            customView.configure(
                cityNameValue: weatherDecode.name,
                temperatureValue: self?.kelvinToCelsius(kelvin: weatherDecode.main.temp) ?? "no value",
                detailsValue: weatherDecode.weather.first?.description ?? "no value",
                imageValue: weatherDecode.weather.first?.icon ?? "logo"
            )
            let name = Notification.Name(rawValue: "WeatherLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    }
    
    private func kelvinToCelsius(kelvin: Double) -> String {
        return String(format:"%.1f", (kelvin - 273.15))
    }
    
    @objc func weatherLoaded() {
        activityIndicator.isHidden = true
        originWeatherView.isHidden = false
        destinyWeatherView.isHidden = false
    }
}
