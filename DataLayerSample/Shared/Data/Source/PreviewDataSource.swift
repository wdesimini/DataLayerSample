//
//  PreviewDataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 1/10/22.
//

import Foundation

/// **PreviewDataSource**
/// Empty concrete DataSource
/// to use during previews in SwiftUI view files
struct PreviewDataSource: DataSource {
    func create(
        _ data: Data,
        at path: Path,
        completion: @escaping Handler
    ) {
        completion()
    }
    
    func delete(
        at path: Path,
        completion: @escaping ErrorHandler
    ) {
        completion(nil)
    }
    
    func read(
        at path: Path,
        completion: @escaping ReadHandler
    ) {
        completion(.success(nil))
    }
    
    func update(
        _ data: Data,
        at path: Path,
        completion: @escaping ErrorHandler
    ) {
        completion(nil)
    }
}
