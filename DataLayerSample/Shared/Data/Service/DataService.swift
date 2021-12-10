//
//  DataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

extension DataServiceable {
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}

class DataService<T: DataServiceable>: ObservableObject {
    private let database = DatabaseManager.shared
    private let decoder = JSONDecoder()
    @Published private(set) var objectsById = [T.ID: T]()
    
    func create(_ object: T) {
        guard let data = object.data else { return }
        let path = object.pathComponents
        database.create(data, at: path)
        objectsById[object.id] = object
    }
    
    func delete(_ object: T) {
        let path = object.pathComponents
        try! database.delete(at: path)
        objectsById.removeValue(forKey: object.id)
    }
    
    func read(objectWithId id: T.ID) -> T? {
        if let object = objectsById[id] { return object }
        let path = T.pathComponents(id: id)
        let data = try? database.read(at: path)
        let object = data.flatMap { try? decoder.decode(T.self, from: $0) }
        object.flatMap { objectsById[$0.id] = $0 }
        return object
    }
    
    func update(_ object: T) {
        guard let data = object.data else { return }
        let path = object.pathComponents
        try! database.update(data, at: path)
        objectsById[object.id] = object
    }
    
    func register() throws {
        try DatabaseManager.shared.register(T.self)
    }
}
