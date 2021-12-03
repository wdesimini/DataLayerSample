//
//  FileManager+TestableDatabase.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/3/21.
//

import Foundation

extension FileManager: TestableDatabase {
    func reset() throws {
        let url = try documentsDirectory()
        let fileURLs = try contentsOfDirectory(at: url,
                                               includingPropertiesForKeys: nil,
                                               options: .skipsHiddenFiles)
        try fileURLs.forEach(removeItem(at:))
    }
}
