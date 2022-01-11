//
//  ChangeRateProtocol.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 11/01/2022.
//

import Foundation

protocol ChangeRateServiceProtocol {
    func getData(completionHandler: @escaping (Result<Fixer, Error>) -> ())
}
