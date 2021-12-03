//
//  Database.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

protocol Database {
    func execute(request: DatabaseRequest) -> DatabaseResponse
}

protocol LocalDatabase: Database {
    func createDirectory(title: String) throws
}

protocol TestableDatabase: Database {
    func reset() throws
}
