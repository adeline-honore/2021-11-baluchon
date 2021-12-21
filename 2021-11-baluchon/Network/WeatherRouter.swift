//
//  WeatherRouter.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

enum WeatherRouter: RouterProtocol {
    
    var baseURL: String {
        "http://api.openweathermap.org/data/2.5/weather?"
    }
    
    case getWeather(cityName: String)
    
    func buildParams() -> URL? {
        switch self {
        case .getWeather(let cityName):
            var weatherComponents = URLComponents(string: baseURL)
            
            weatherComponents?.queryItems = [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: "23b15536e795f12d8cf140cb43b8ab8e")
            ]
            return URL(string: weatherComponents?.string ?? "")
        }
    }
    
    func asUrlRequest() -> URLRequest? {
        guard let url = buildParams() else {
            return nil
        }
        return URLRequest(url: url)
    }
}
