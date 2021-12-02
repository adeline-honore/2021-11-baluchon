//
//  Constants.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation


class Constants {
    
    static func getChangeRateRouter() -> URL {
        var changeRateComponents = URLComponents()
        changeRateComponents.scheme = HTTP
        changeRateComponents.host = "data.fixer.io"
        changeRateComponents.path = "/api/latest"
        
        changeRateComponents.queryItems = [
            URLQueryItem(name: "access_key", value: "7f3ca3bafe654134abd06e9450f7f720"),
            URLQueryItem(name: "symbols", value: "USD")
        ]
        
        guard let url = URL(string: changeRateComponents.string ?? "") else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    
    static func getWeatherRouter() -> URL {
        var weatherComponents = URLComponents()
        weatherComponents.scheme = HTTP
        weatherComponents.host = "api.openweathermap.org"
        weatherComponents.path = "/data/2.5/weather"
        
        weatherComponents.queryItems = [
            URLQueryItem(name: "q", value: "paris"),
            URLQueryItem(name: "appid", value: "23b15536e795f12d8cf140cb43b8ab8e")
        ]
        
        guard let url = URL(string: weatherComponents.string ?? "") else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    //MARK: - HTTP
    
    static let HTTP = "http"
    
}

