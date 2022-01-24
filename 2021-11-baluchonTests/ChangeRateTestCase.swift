//
//  ChangeRateTestCase.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 18/01/2022.
//

@testable import _021_11_baluchon
import XCTest

class ChangeRateTestCase: XCTestCase {
    
    // Given
    var changeRate = ChangeRateService(network: NetworkFake(testCase: .changeRate))
    
    override func setUp() {
        super.setUp()
        changeRate = ChangeRateService(network: NetworkFake(testCase: .changeRate))
    }
    
    override func tearDown() {
        super.setUp()
        //changeRate = nil
    }

    func testChangeRateShouldPostFailedCallbackIfResulIsNil() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
           XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostFailedCallbackIfIncorrectData() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        let changeRateIncorrectData = "erreur".data(using: .utf8)!
        changeRate.getData { result in
            XCTAssertNoThrow(changeRateIncorrectData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostSuccess() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            XCTAssertNoThrow(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
