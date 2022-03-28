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
    func register(
        type: String,
        completion: @escaping ErrorHandler
    ) {
        completion(nil)
    }
    
    func loadData(
        at path: Path,
        completion: @escaping LoadHandler
    ) {
        completion(.success(nil))
    }
    
    func saveData(
        _ data: Data?,
        at path: Path,
        completion: @escaping ErrorHandler
    ) {
        completion(nil)
    }
}
