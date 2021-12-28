//
//  WeatherService.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    
    var network: NetworkProtocol = Network()
    
    func getData(city: Int,completionHandler: @escaping (Result<WeatherStructure, Error>) -> ()) {
        
        network.callNetwork(router: WeatherRouter.getWeather(cityID: city)) { result in
            
            switch result {
            case .success(let data):
                let weather = self.transformToWeather(data: data)
                completionHandler(.success(weather))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func transformToWeather(data: Data) -> WeatherStructure {
        var responseWeather: WeatherStructure
        let data = data
        responseWeather = try! JSONDecoder().decode(WeatherStructure.self, from: data)
        return responseWeather
    }
}
