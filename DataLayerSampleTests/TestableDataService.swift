//
//  TestableDataService.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 1/9/22.
//

@testable import DataLayerSample

extension DataService {
    func reset() throws {
        let type = T.directoryTitle
        let source = source as! TestableDataSource
        try source.reset(type: type)
        let objects = [T](objectsById.values)
        objects.forEach(delete(_:))
    }
}
