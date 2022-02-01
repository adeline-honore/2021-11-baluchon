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
    private var weather: WeatherService!
    private let cityID = 6000
    
    private func initSUT(isFailed: Bool = false) {
        weather = WeatherService(network: NetworkFake(testCase: .weather, isFailed: isFailed))
    }
    
    override func tearDown() {
        super.setUp()
        weather = nil
    }
    
    func testWeatherShouldPostSuccess() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccessOnDataName() {
        // Given
        let nameReceived = "Mountain View"
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().name, nameReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccessOnDataTemperatureValue() {
        // Given
        let temperatureReceived = 282.55
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().main.temp, temperatureReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccessOnDataWindSpeed() {
        // Given
        let windSpeedReceived = 1.5
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().wind.speed, windSpeedReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccessOnDataIcon() {
        // Given
        let iconReceived = "01d"
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        weather.getData(city: cityID) { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().weather.first?.icon, iconReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldReturnFailure() {
        // Given
        initSUT(isFailed: true)
        // When
        let expectation = XCTestExpectation(description: "Should return failure")
        // Then
        weather.getData(city: cityID) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
