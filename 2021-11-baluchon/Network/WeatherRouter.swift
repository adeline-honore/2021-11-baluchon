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
    
    var accessKey: String {
        "&appid=23b15536e795f12d8cf140cb43b8ab8e"
    }
    
    case getWeather(parameter: String)
    case getOtherThing(param1: String, param2: String)
    
    func buildParams() -> URL? {
        switch self {
        case .getWeather(let parameter):
            return URL(string: baseURL+Constants.weatherCity+parameter+accessKey)
        case .getOtherThing(let param1, let param2):
            return nil
        }
    }
    
    func asUrlRequest() -> URLRequest? {
        guard let url = buildParams() else {
            return nil
        }
        return URLRequest(url: url)
    }
}
