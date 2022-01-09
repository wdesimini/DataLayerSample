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
        try data.reset()
    }
    
    func testCreateContent() throws {
        let data = self.data.contentData
        let content = try createSampleContent(data: data)
        let stored = data.read(objectWithId: content.id)
        XCTAssertNotNil(stored)
    }
    
    func testDeleteContent() throws {
        // create
        let data = self.data.contentData
        let content = try createSampleContent(data: data)
        let stored = data.read(objectWithId: content.id)
        XCTAssertNotNil(stored)
        
        // delete
        data.delete(content)
        let deleted = data.read(objectWithId: content.id)
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

// MARK: Utility

extension DataLayerSampleTests {
    private func createSampleContent(data: DataService<Content>) throws -> Content {
        let idString = "70881D22-E283-42BF-809B-656D8D57518C"
        let contentId = UUID(uuidString: idString)!
        let text = "What da dog doin?"
        let content = Content(id: contentId, text: text)
        data.create(content)
        return content
    }
}
