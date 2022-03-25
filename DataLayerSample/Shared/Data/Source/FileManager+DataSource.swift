//
//  FileManager+DataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 1/9/22.
//

import Foundation

// MARK: DataSource

extension FileManager: DataSource {
    static var readQueue: DispatchQueue {
        .main
    }
    
    static var writeQueue: DispatchQueue {
        .global(qos: .background)
    }
    
    func loadData(
        at path: Path,
        completion: @escaping LoadHandler
    ) {
        FileManager.writeQueue.async {
            let result: Result<Data?, Error>
            do {
                let data = try self.load(at: path)
                result = .success(data)
            } catch {
                result = .failure(error)
            }
            FileManager.readQueue.async {
                completion(result)
            }
        }
    }
    
    func saveData(
        _ data: Data?,
        at path: Path,
        completion: @escaping ErrorHandler
    ) {
        FileManager.writeQueue.async {
            let saveError: Error?
            do {
                try self.save(data, at: path)
                saveError = nil
            } catch {
                saveError = error
            }
            FileManager.readQueue.async {
                completion(saveError)
            }
        }
    }
    
    func register(
        type: String,
        completion: @escaping ErrorHandler
    ) {
        FileManager.writeQueue.async {
            let registerError: Error?
            do {
                try self.createDirectory(title: type)
                registerError = nil
            } catch {
                registerError = error
            }
            FileManager.readQueue.async {
                completion(registerError)
            }
        }
    }
}

// MARK: Utilities

extension FileManager {
    func load(at path: Path) throws -> Data? {
        let url = url(path: path)
        let path = url.path
        return (fileExists(atPath: path)
                ? try Data(contentsOf: url)
                : nil)
    }
    
    func save(_ data: Data?, at path: Path) throws {
        let url = url(path: path)
        let path = url.path
        if fileExists(atPath: path) {
            try removeItem(at: url)
        }
        if let data = data {
            createFile(atPath: path, contents: data)
        }
    }
    
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
