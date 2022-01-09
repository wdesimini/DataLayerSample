//
//  DataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

class DataService<T: DataServiceable>: ObservableObject {
    private let source: DataSource
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    @Published private(set) var objectsById = [T.ID: T]()
    
    init(source: DataSource) {
        self.source = source
    }
    
    func create(_ object: T) {
        guard let data = try? encoder.encode(object) else { return }
        let path = object.pathComponents
        source.create(data, at: path)
        objectsById[object.id] = object
    }
    
    func delete(_ object: T) {
        let path = object.pathComponents
        try! source.delete(at: path)
        objectsById.removeValue(forKey: object.id)
    }
    
    func read(objectWithId id: T.ID) -> T? {
        if let object = objectsById[id] { return object }
        let path = T.pathComponents(id: id)
        let data = try? source.read(at: path)
        let object = data.flatMap { try? decoder.decode(T.self, from: $0) }
        object.flatMap { objectsById[$0.id] = $0 }
        return object
    }
    
    func update(_ object: T) {
        guard let data = try? encoder.encode(object) else { return }
        let path = object.pathComponents
        try! source.update(data, at: path)
        objectsById[object.id] = object
    }
    
    func register() throws {
        let type = T.directoryTitle
        try source.register(type: type)
    }
    
    func reset() throws {
        let type = T.directoryTitle
        try source.reset(type: type)
        objectsById.removeAll()
    }
}
