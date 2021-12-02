//
//  FileManager+Service.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/3/21.
//

import Foundation

extension FileManager {
    
    // MARK: Directories
    
    func create(directoryAt url: URL) throws {
        try createDirectory(at: url,
                            withIntermediateDirectories: false,
                            attributes: nil)
    }
    
    func directory(existsAt url: URL) -> Bool {
        var exists: ObjCBool = false
        fileExists(atPath: url.path, isDirectory: &exists)
        return exists.boolValue
    }
    
    func documentsDirectory() throws -> URL {
        try url(for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
    }
    
    // MARK: Files
    
    func create(_ data: Data, at url: URL) {
        createFile(atPath: url.path, contents: data)
    }
    
    func delete(at url: URL) throws {
        try removeItem(at: url)
    }
    
    func fileExists(at url: URL) -> Bool {
        fileExists(atPath: url.path)
    }
    
    func read(at url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
    
    func update(_ data: Data, at url: URL) throws {
        try delete(at: url)
        create(data, at: url)
    }
    
    // MARK: Utilities
    
    func reset() throws {
        let url = try documentsDirectory()
        let fileURLs = try contentsOfDirectory(at: url,
                                               includingPropertiesForKeys: nil,
                                               options: .skipsHiddenFiles)
        try fileURLs.forEach(removeItem(at:))
    }
}
