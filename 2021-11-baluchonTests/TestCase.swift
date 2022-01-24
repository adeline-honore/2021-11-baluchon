//
//  TestCase.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 24/01/2022.
//

import Foundation

enum TestCase {
    case changeRate
    case weather
    case translate
    var resource: String {
        switch self {
        case .changeRate:
            return "ChangeRate"
        case .weather:
            return "Weather"
        case .translate:
            return "Translate"
        }
    }
}
