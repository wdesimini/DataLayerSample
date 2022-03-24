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
        let services: [MockDataServicer] = [
            contentData,
            contentChildData
        ]
        do {
            try services.forEach {
                try $0.createMockData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func register() {
        let group = DispatchGroup()
        var error: Error?
        let services: [RegisteredDataServicer] = [
            contentData,
            contentChildData
        ]
        for service in services {
            group.enter()
            service.register {
                error = $0 ?? error
                group.leave()
            }
        }
        group.notify(queue: .main) {
            error.flatMap {
                print($0.localizedDescription)
            }
        }
    }
}
