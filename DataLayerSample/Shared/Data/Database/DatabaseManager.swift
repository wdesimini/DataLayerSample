//
//  DatabaseManager.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let local: LocalDatabase
    
    private init(local: LocalDatabase = FileManager.default) {
        self.local = local
    }
    
    func create(_ data: Data, at path: [String]) {
        local.create(data, at: path)
    }
    
    func delete(at path: [String]) throws {
        try local.delete(at: path)
    }
    
    func read(at path: [String]) throws -> Data? {
        try? local.read(at: path)
    }
    
    func update(_ data: Data, at path: [String]) throws {
        try local.update(data, at: path)
    }
    
    func register<T>(_ objectClass: T.Type) throws where T: DataServiceable {
        let path = T.directoryTitle
        try local.createDirectory(title: path)
    }
    
    func reset() throws {
        let local = self.local as! TestableDatabase
        try local.reset()
    }
}
