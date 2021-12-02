//
//  WeatherService.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    
    var network: NetworkProtocol = Network()
    
    func getData(completionHandler: @escaping (Result<WeatherStruct, Error>) -> ()) {
        
        network.callNetwork(router: WeatherRouter()) { result in
            
            switch result {
            case .success(let data):
                let weather = self.transformToWeather(data: data)
                completionHandler(.success(weather))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func transformToWeather(data: Data) -> WeatherStruct {
        var responseWeather: WeatherStruct
        let data = data
        responseWeather = try! JSONDecoder().decode(WeatherStruct.self, from: data)
        return responseWeather
    }
}
