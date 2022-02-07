//
//  Fixer.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

struct Fixer : Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}

enum FixerCurrency {
    case usd, euro
}
