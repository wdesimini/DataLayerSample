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
    let contentChildData: DataService<ContentChild>
    
    private init(source: DataSource) {
        contentData = .init(source: source)
        contentChildData = .init(source: source)
    }
    
    private func createMockData() {
        do {
            try contentData.createMockData()
            try contentChildData.createMockData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func register() throws {
        try contentData.register()
    }
}
