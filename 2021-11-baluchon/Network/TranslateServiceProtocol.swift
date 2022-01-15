//
//  TranslateServiceProtocol.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 15/01/2022.
//

import Foundation

protocol TranslateServiceProtocol {
    func getData(text: String, completionHandler: @escaping  (Result<TranslateStructure, Error>) -> ())
}
