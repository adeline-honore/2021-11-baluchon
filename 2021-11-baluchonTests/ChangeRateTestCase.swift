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
    
    func testChangeRateOnDataSuccess() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try! result.get().success, true)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateOnDataTimestamp() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try! result.get().timestamp, 1642512844)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateOnDataBase() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try! result.get().base, "EUR")
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateOnDataDate() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try! result.get().date, "2022-01-18")
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeRateOnDataRate() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        changeRate.getData { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try! result.get().rates.first?.key, "USD")
                XCTAssertEqual(try! result.get().rates.first?.value, 1.137508)
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
