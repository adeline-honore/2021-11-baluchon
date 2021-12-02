//
//  ErrorType.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

enum ErrorType: Error {
    case noAmount
    case network
    case multiDecimal
    
    
    var message: String {
        switch self {
        case .noAmount:
            return "No amount in text field"
        case .network:
            return "Oups!, no return from API"
        case .multiDecimal:
            return "Oups!, multi decimal"
        }
    }
}
