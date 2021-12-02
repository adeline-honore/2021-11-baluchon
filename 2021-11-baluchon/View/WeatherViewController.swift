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
                self.update(weather: weather)
            case .failure:
                self.errorMessage(element: .network)
            }
        }
    }
    
    private func update(weather: WeatherStruct) {
        DispatchQueue.main.async {
            self.weatherView.localWeatherTemperature.text = String(weather.coord.lat)
        }
    }
}
