//
//  NetworkProtocol.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

protocol NetworkProtocol {
    func callNetwork(router: RouterProtocol, completionHandler: @escaping (Result<Data, Error>) -> ())
}
