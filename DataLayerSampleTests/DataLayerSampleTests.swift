//
//  DataLayerSampleTests.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 12/1/21.
//

import XCTest
@testable import DataLayerSample

class DataLayerSampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try DatabaseManager.shared.reset()
    }

    func testReadMockContent() throws {
        let data = DataManager.preview.contentData
        let values = data.objectsById.values
        let sample = values.first
        XCTAssertNotNil(sample)
    }
}
