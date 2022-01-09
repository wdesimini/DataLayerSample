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
    private var content: Content?

    override func setUpWithError() throws {
        try data.register()
    }

    override func tearDownWithError() throws {
        try data.reset()
        content = nil
    }
    
    func testCreateContent() throws {
        // create
        let service = data.contentData
        let content = Content(id: UUID(), text: "What da dog doin?")
        service.create(content)
        self.content = content
        
        // check content created
        let stored = service.read(objectWithId: content.id)
        XCTAssertNotNil(stored)
    }
    
    func testDeleteContent() throws {
        // create
        try testCreateContent()
        XCTAssertNotNil(content)
        
        // delete
        let service = data.contentData
        service.delete(content!)
        let deleted = service.read(objectWithId: content!.id)
        XCTAssertNil(deleted)
    }

    func testReadMockContent() throws {
        // initiate/read preview data
        let data = DataManager.preview.contentData
        let values = data.objectsById.values
        let sample = values.first
        XCTAssertNotNil(sample)
        
        // compare against mock data file
        let mock = try data.mockData()
        let mockContent = try JSONDecoder().decode(Content.self, from: mock)
        XCTAssertTrue(mockContent.id == sample!.id)
        XCTAssertTrue(mockContent.text == sample!.text)
    }
}
