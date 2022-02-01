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
    private var translate: TranslateService!
    private let textReceived = "here is a standard text that I want to translate"
    
    private func initSUT(isFailed: Bool = false) {
        translate = TranslateService(network: NetworkFake(testCase: .translate, isFailed: isFailed))
    }
    
    override func tearDown() {
        super.setUp()
        translate = nil
    }

    func testTranslateShouldPostSuccess() {
        // Given
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        translate.getData(text: textReceived) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostSuccessOnDataTranslatedText() {
        // Given
        let sentenceReceived = "ici j'ai un texte standard que je veux traduire"
        initSUT()
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        // Then
        translate.getData(text: textReceived) { result in
            switch result {
            case .success(_):
                XCTAssertEqual(try? result.get().data.translations.first?.translatedText, sentenceReceived)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldReturnFailure() {
        // Given
        initSUT(isFailed: true)
        // When
        let expectation = XCTestExpectation(description: "Should return failure")
        // Then
        translate.getData(text: textReceived) { result in
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
