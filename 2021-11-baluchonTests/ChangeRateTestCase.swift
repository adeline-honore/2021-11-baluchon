//
//  ChangeRateTestCase.swift
//  2021-11-baluchonTests
//
//  Created by HONORE Adeline on 18/01/2022.
//

@testable import _021_11_baluchon
import XCTest

class ChangeRateTestCase: XCTestCase {
    
    private var changeRate: ChangeRateService!
    
    override func tearDown() {
        super.setUp()
        changeRate = nil
    }
    
    private func initSUT(isFailed: Bool = false) {
        changeRate = ChangeRateService(network: NetworkFake(testCase: .changeRate, isFailed: isFailed))
    }
    
    func testChangeRateShouldPostSuccess() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostSuccessOnDataSuccess() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().success, true)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostSuccessOnDataTimestamp() {
        // Given
        let timestampReceived = 1642512844
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().timestamp, timestampReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostSuccessOnDataBase() {
        // Given
        let baseReceived = "EUR"
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().base, baseReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostSuccessOnDataDate() {
        // Given
        let dateReceived = "2022-01-18"
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().date, dateReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldPostSuccessOnDataRate() {
        // Given
        let currencyReceived = "USD"
        let rateReceived = 1.137508
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().rates.first?.key, currencyReceived)
                XCTAssertEqual(try? result.get().rates.first?.value, rateReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateShouldReturnFailure() {
        // Given
        initSUT(isFailed: true)
        // When
        let expectation = XCTestExpectation(description: "Should return failure")
        // Then
        changeRate.getData { result in
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
