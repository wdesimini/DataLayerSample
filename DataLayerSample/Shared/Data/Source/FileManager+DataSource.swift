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
                let data = try self.loadDataSyncly(at: path)
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
                try self.saveDataSyncly(data, at: path)
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
                try self.registerSyncly(type: type)
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
