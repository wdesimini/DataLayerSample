//
//  Database.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

protocol Database {
    func create(_ data: Data, at path: [String])
    func delete(at path: [String]) throws
    func read(at path: [String]) throws -> Data
    func update(_ data: Data, at path: [String]) throws
}

protocol LocalDatabase: Database {
    func createDirectory(title: String) throws
}

protocol TestableDatabase: Database {
    func reset() throws
}
