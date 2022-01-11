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
    
    private let originCity: Int = 6690604
    private let destinationCity: Int = 5128638
    
    
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
    
    private func showWeatherInformations(city: Int, weatherView: CustomWeatherView) {
        
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
                detailsValue: self?.windSpeedCalculation(speed: weatherDecode.wind.speed) ?? "no value",
                imageValue: weatherDecode.weather.first?.icon ?? "logo"
            )
            let name = Notification.Name(rawValue: "WeatherLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
            
            self?.setCustomView(customView: customView)
        }
    }
    
    private func kelvinToCelsius(kelvin: Double) -> String {
        return String(format:"%.1f", (kelvin - 273.15)) + " °C"
    }
    
    private func windSpeedCalculation(speed: Double) -> String {
        return "wind speed : " + String(format:"%.0f", (speed * 3.6)) + " km/h"
    }
    
    private func setCustomView(customView: CustomWeatherView) {
        guard let originWeatherImage = UIImage(named: "originWeatherImage"),
              let destinyWeatherImage = UIImage(named: "destinyWeatherImage") else
              {
                  return
              }
        
        if customView == originWeatherView {
            customView.backgroundColor = UIColor(patternImage: originWeatherImage).withAlphaComponent(0.5)
        } else {
            customView.backgroundColor = UIColor(patternImage: destinyWeatherImage).withAlphaComponent(0.7)
        }
    }
    
    @objc func weatherLoaded() {
        activityIndicator.isHidden = true
        originWeatherView.isHidden = false
        destinyWeatherView.isHidden = false
    }
}
