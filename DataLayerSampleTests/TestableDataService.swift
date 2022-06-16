//
//  TestableDataService.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 1/9/22.
//

@testable import DataLayerSample

protocol TestableDataService {
    func registerSyncly() throws
    func resetSyncly() throws
}

extension DataService: TestableDataService {
    func registerSyncly() throws {
        let type = T.directoryTitle
        let source = source as! TestableDataSource
        try source.registerSyncly(type: type)
    }

    func resetSyncly() throws {
        let type = T.directoryTitle
        let source = source as! TestableDataSource
        try source.resetSyncly(type: type)
        let objects = [T](objectsById.values)
        objects.forEach(delete(_:))
    }
}
