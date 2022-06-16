//
//  FileManager+TestableDatasource.swift
//  DataLayerSampleTests
//
//  Created by Wilson Desimini on 1/9/22.
//

@testable import DataLayerSample
import Foundation

extension FileManager: TestableDataSource {
    func registerSyncly(type: String) throws {
        try createDirectory(title: type)
    }

    func resetSyncly(type: String) throws {
        let path = [type]
        let url = url(path: path)
        var exists: ObjCBool = false
        fileExists(atPath: url.path, isDirectory: &exists)
        guard exists.boolValue else { return }
        try removeItem(at: url)
    }
}
