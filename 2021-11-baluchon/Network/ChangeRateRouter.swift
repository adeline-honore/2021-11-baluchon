//
//  ChangeRateRouter.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

enum ChangeRateRouter: RouterProtocol {
    
    var baseURL: String {
    "http://data.fixer.io/api/latest?access_key=7f3ca3bafe654134abd06e9450f7f720&symbols=USD"
    }
    
    var accessKey: String {
        "access_key=7f3ca3bafe654134abd06e9450f7f720"
    }
    
    case getRate(parameter: String)
    case getOtherThing(param1: String, param2: String)
    
    
    func buildParams() -> URL? {
        switch self {
        case .getRate(let parameter):
            return URL(string: baseURL+accessKey+Constants.symbolCurrency+parameter)
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
