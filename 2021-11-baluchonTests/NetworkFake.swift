//
//  NetworkFake.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 18/01/2022.
//

import Foundation
@testable import _021_11_baluchon

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

class NetworkFake: NetworkProtocol {
    
    private let testCase : TestCase
    private let extensionType = "json"
    
    init(testCase: TestCase) {
        self.testCase = testCase
    }
    
    func callNetwork(router: RouterProtocol, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        
        let bundle = Bundle(for: NetworkFake.self)
        guard let url = bundle.url(forResource: testCase.resource, withExtension: extensionType) else {
            completionHandler(.failure(ErrorType.network))
            return
        }
        let data = try! Data(contentsOf: url)
        
        completionHandler(.success(data))
    }
    
    
}
