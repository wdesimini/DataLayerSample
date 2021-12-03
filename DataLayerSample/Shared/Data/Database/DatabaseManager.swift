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
    
    func execute(request: DatabaseRequest) -> DatabaseResponse {
        let response = local.execute(request: request)
        return response
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
