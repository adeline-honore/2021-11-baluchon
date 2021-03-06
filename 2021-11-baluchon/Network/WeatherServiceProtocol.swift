//
//  WeatherServiceProtocol.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

protocol WeatherServiceProtocol {
    func getData(city: Int, completionHandler: @escaping (Result<WeatherStructure, Error>) -> ())
}
