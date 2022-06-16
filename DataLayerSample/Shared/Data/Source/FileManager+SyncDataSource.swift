//
//  FileManager+SyncDataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

extension FileManager: SyncDataSource {
    func loadDataSyncly(at path: Path) throws -> Data? {
        let url = url(path: path)
        let path = url.path
        return (fileExists(atPath: path)
                ? try Data(contentsOf: url)
                : nil)
    }

    func saveDataSyncly(_ data: Data?, at path: Path) throws {
        let url = url(path: path)
        let path = url.path
        if fileExists(atPath: path) {
            try removeItem(at: url)
        }
        if let data = data {
            createFile(atPath: path, contents: data)
        }
    }

    func registerSyncly(type: String) throws {
        try createDirectory(title: type)
    }

    func resetSyncly(type: String) throws {
        let path = [type]
        try saveDataSyncly(nil, at: path)
    }
}
