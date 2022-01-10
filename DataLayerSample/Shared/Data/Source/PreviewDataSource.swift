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
    func create(_ data: Data, at path: Path) {
    }
    
    func delete(at path: Path) throws {
    }
    
    func read(at path: Path) throws -> Data? {
        nil
    }
    
    func update(_ data: Data, at path: Path) throws {
    }
}
