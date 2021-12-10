//
//  DataLayerSampleTests.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 12/1/21.
//

import XCTest
@testable import DataLayerSample

class DataLayerSampleTests: XCTestCase {
    private let data = DataManager.shared

    override func setUpWithError() throws {
        try data.register()
    }

    override func tearDownWithError() throws {
        try DatabaseManager.shared.reset()
    }
    
    func testRandomDog() throws {
        let expectation = self.expectation(description: "Doge")
        var dog: Dog? = nil
        data.dogData.newPupper {
            dog = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(dog)
    }
}
