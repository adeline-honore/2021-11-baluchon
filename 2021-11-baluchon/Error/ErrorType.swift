//
//  ErrorType.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

enum ErrorType: Error {
    case empty
    case network
    case multiDecimal
    
    
    var message: String {
        switch self {
        case .empty:
            return "Text field is empty !"
        case .network:
            return "Oups!, no return from API ."
        case .multiDecimal:
            return "Oups!, multi decimal ."
        }
    }
}
