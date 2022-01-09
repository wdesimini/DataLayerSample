//
//  FileManager+DataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 1/9/22.
//

import Foundation

// MARK: DataSource

extension FileManager: DataSource {
    func create(_ data: Data, at path: Path) {
        let url = url(path: path)
        let path = url.path
        createFile(atPath: path, contents: data)
    }
    
    func delete(at path: Path) throws {
        let url = url(path: path)
        let path = url.path
        guard fileExists(atPath: path) else { return }
        try removeItem(at: url)
    }
    
    func read(at path: Path) throws -> Data? {
        let url = url(path: path)
        let path = url.path
        let exists = fileExists(atPath: path)
        guard exists else { return nil }
        return try Data(contentsOf: url)
    }
    
    func register(type: String) throws {
        try createDirectory(title: type)
    }
    
    func update(_ data: Data, at path: Path) throws {
        try delete(at: path)
        create(data, at: path)
    }
}

// MARK: Utilities

extension FileManager {
    private func createDirectory(title: String) throws {
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
