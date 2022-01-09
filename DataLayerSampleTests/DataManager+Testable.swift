//
//  DataManager+Testable.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 1/9/22.
//

@testable import DataLayerSample

extension DataManager {
    func reset() throws {
        try contentData.reset()
    }
}
