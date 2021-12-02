//
//  WeatherRouter.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

class WeatherRouter: RouterProtocol {
    
    func asUrlRequest() -> URLRequest? {
        let url = Constants.getWeatherRouter()
        return URLRequest(url: url)
    }
}
