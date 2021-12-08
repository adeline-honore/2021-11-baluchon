//
//  RouterProtocol.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

protocol RouterProtocol {
    var baseURL: String { get }
    func buildParams() -> URL?
    func asUrlRequest() -> URLRequest?
}
