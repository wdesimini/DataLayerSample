//
//  DataManager.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Foundation

class DataManager {
    static let preview: DataManager = {
        let source = PreviewDataSource()
        let manager = DataManager(source: source)
        manager.createMockData()
        return manager
    }()
    static let shared = DataManager(source: FileManager.default)
    
    let contentData: DataService<Content>
    
    private init(source: DataSource) {
        contentData = .init(source: source)
    }
    
    private func createMockData() {
        try! contentData.createMockData()
    }
    
    func register() throws {
        try contentData.register()
    }
}
