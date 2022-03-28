//
//  FileManager+Utilities.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

extension FileManager {
    func createDirectory(title: String) throws {
        let baseURL = try documentsDirectory()
        let url = baseURL.appendingPathComponent(title)
        let exists = directoryExists(at: url)
        guard !exists else { return }
        try createDirectory(at: url,
                            withIntermediateDirectories: false,
                            attributes: nil)
    }
    
    func directoryExists(at url: URL) -> Bool {
        var exists: ObjCBool = false
        fileExists(atPath: url.path, isDirectory: &exists)
        return exists.boolValue
    }
    
    private func documentsDirectory() throws -> URL {
        try url(for: .documentDirectory,
                   in: .userDomainMask,
                   appropriateFor: nil,
                   create: false)
    }
    
    func url(path: Path) -> URL {
        let baseUrl = try! documentsDirectory()
        return path.reduce(baseUrl) { $0.appendingPathComponent($1) }
    }
}
