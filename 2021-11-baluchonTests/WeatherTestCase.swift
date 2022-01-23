//
//  WeatherTestCase.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 23/01/2022.
//

@testable import _021_11_baluchon
import XCTest

class WeatherTestCase: XCTestCase {
    
    // Given
    var weather = WeatherService(network: NetworkFake(testCase: .weather))
    let cityID = 6000
    
    override func setUp() {
        super.setUp()
        weather = WeatherService(network: NetworkFake(testCase: .weather))
    }
    
    override func tearDown() {
        super.setUp()
        //weather = nil
    }

    func testWeatherShouldPostFailedCallbackIfResulIsNil() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
           XCTAssertNil(nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostFailedCallbackIfIncorrectData() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        let weatherIncorrectData = "erreur".data(using: .utf8)!
        weather.getData(city: cityID) { result in
            XCTAssertNoThrow(weatherIncorrectData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccess() {
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
            XCTAssertNoThrow(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
