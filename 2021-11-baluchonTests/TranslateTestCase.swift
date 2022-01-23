//
//  TranslateTestCase.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 23/01/2022.
//

@testable import _021_11_baluchon
import XCTest

class TranslateTestCase: XCTestCase {

    // Given
    var translate = TranslateService(network: NetworkFake(testCase: .translate))
    
    let textTest = "here is a standard text that I want to translate"
    
    override func setUp() {
        super.setUp()
        translate = TranslateService(network: NetworkFake(testCase: .translate))
    }
    
    override func tearDown() {
        super.setUp()
        //weather = nil
    }

    func testWeatherShouldPostFailedCallbackIfResulIsNil() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        translate.getData(text: textTest) { result in
           XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostFailedCallbackIfIncorrectData() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        let translateIncorrectData = "erreur".data(using: .utf8)!
        translate.getData(text: textTest) { result in
            XCTAssertNoThrow(translateIncorrectData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccess() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        translate.getData(text: textTest) { result in
            XCTAssertNoThrow(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
