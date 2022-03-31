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
        #if DEBUG
        resetSyncly()
        #endif
    }
    
    private var services: [Any] {
        [
            contentData,
            contentChildData
        ]
    }
    
    private func createMockData() {
        guard let services = services as? [MockDataCreator] else {
            return
        }
        do {
            try services.forEach {
                try $0.createMockData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func register() {
        guard let services = services as? [DataRegistrar] else {
            return
        }
        let group = DispatchGroup()
        var error: Error?
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
    
    private func resetSyncly() {
        guard let services = services as? [DataResetter] else {
            return
        }
        do {
            try services.forEach {
                try $0.resetSyncly()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
