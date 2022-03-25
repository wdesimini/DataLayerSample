//
//  DataManager+Testable.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 1/9/22.
//

@testable import DataLayerSample

extension DataManager {
    private var services: [TestableDataService] {
        [
            contentData,
            contentChildData
        ]
    }
    
    func registerSyncly() throws {
        try services.forEach {
            try $0.registerSyncly()
        }
    }
    
    func resetSyncly() throws {
        try services.forEach {
            try $0.resetSyncly()
        }
    }
}
