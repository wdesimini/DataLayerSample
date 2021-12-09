//
//  FileManager+Database.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

// MARK: Local

extension FileManager: LocalDatabase {
    func create(_ data: Data, at path: [String]) {
        create(data, at: url(path: path))
    }
    
    func createDirectory(title: String) throws {
        let baseURL = try documentsDirectory()
        let url = baseURL.appendingPathComponent(title)
        let exists = directory(existsAt: url)
        guard !exists else { return }
        try create(directoryAt: url)
    }
    
    func delete(at path: [String]) throws {
        try delete(at: url(path: path))
    }
    
    func read(at path: [String]) throws -> Data {
        try read(at: url(path: path))
    }
    
    func update(_ data: Data, at path: [String]) throws {
        try update(data, at: url(path: path))
    }
    
    private func url(path: [String]) -> URL {
        let baseUrl = try! documentsDirectory()
        return path.reduce(baseUrl) { $0.appendingPathComponent($1) }
    }
}

// MARK: Testable

extension FileManager: TestableDatabase {
    func reset() throws {
        let url = try documentsDirectory()
        let fileURLs = try contentsOfDirectory(at: url,
                                               includingPropertiesForKeys: nil,
                                               options: .skipsHiddenFiles)
        try fileURLs.forEach(removeItem(at:))
    }
}
