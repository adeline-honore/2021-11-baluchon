//
//  NetworkFake.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 18/01/2022.
//

import Foundation
@testable import _021_11_baluchon

class NetworkFake: NetworkProtocol {
    
    private let testCase : TestCase
    private let extensionType = "json"
    private var isFailed: Bool = false
    
    init(testCase: TestCase, isFailed: Bool = false) {
        self.testCase = testCase
        self.isFailed = isFailed
    }
    
    func callNetwork(router: RouterProtocol, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        
        guard !isFailed else {
            completionHandler(.failure(ErrorType.network))
            return
        }
        
        let bundle = Bundle(for: NetworkFake.self)
        guard let url = bundle.url(forResource: testCase.resource, withExtension: extensionType) else {
            completionHandler(.failure(ErrorType.network))
            return
        }
        let data = try! Data(contentsOf: url)
        
        completionHandler(.success(data))
    }
}
