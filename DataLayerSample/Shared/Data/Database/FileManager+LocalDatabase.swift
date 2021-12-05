//
//  FileManager+LocalDatabase.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

extension FileManager: LocalDatabase {
    func createDirectory(title: String) throws {
        let baseURL = try documentsDirectory()
        let url = baseURL.appendingPathComponent(title)
        let exists = directory(existsAt: url)
        guard !exists else { return }
        try create(directoryAt: url)
    }
    
    func execute(request: DatabaseRequest) -> DatabaseResponse {
        let body = request.body
        let method = request.method
        let path = request.path
        let baseUrl = try! documentsDirectory()
        let url = path.reduce(baseUrl) { $0.appendingPathComponent($1) }
        var data: Data? = nil
        switch method {
        case .delete:
            try! delete(at: url)
        case .get:
            data = try? read(at: url)
        case .patch:
            try! update(body!, at: url)
        case .post:
            create(body!, at: url)
        }
        return DatabaseResponse(data: data, success: true)
    }
}
