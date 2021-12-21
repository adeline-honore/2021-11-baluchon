//
//  ChangeRateRouter.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

enum ChangeRateRouter: RouterProtocol {
    
    var baseURL: String {
    "http://data.fixer.io/api/latest?"
    }
    
    case getRate
    
    func buildParams() -> URL? {
        switch self {
        case .getRate:
            var weatherComponents = URLComponents(string: baseURL)
            
            weatherComponents?.queryItems = [
                URLQueryItem(name: "access_key", value: "7f3ca3bafe654134abd06e9450f7f720"),
                URLQueryItem(name: "symbols", value: "USD")
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
