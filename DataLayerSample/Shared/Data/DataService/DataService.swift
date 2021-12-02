//
//  DataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

class DataService<T: DataServiceable>: ObservableObject {
    @Published private(set) var objectsById = [T.ID: T]()
    
    init() {
        try! DatabaseManager.shared.register(T.self)
    }
    
    func create(_ object: T) {
        let request = DatabaseRequest(method: .post, object: object)
        let response = DatabaseManager.shared.execute(request: request)
        guard response.success else { return }
        objectsById[object.id] = object
    }
    
    func read(objectWithId id: T.ID) -> T? {
        if let object = objectsById[id] { return object }
        let path = T.pathComponents(id: id)
        let request = DatabaseRequest(method: .get, path: path)
        let response = DatabaseManager.shared.execute(request: request)
        let object = response.data.flatMap { try? JSONDecoder().decode(T.self, from: $0) }
        object.flatMap { objectsById[$0.id] = $0 }
        return object
    }
    
    func update(_ object: T) {
        let request = DatabaseRequest(method: .patch, object: object)
        let response = DatabaseManager.shared.execute(request: request)
        guard response.success else { return }
        objectsById[object.id] = object
    }
    
    func delete(_ object: T) {
        let request = DatabaseRequest(method: .delete, object: object)
        let response = DatabaseManager.shared.execute(request: request)
        guard response.success else { return }
        objectsById.removeValue(forKey: object.id)
    }
}

private extension DatabaseRequest {
    init<T>(method: Method, object: T) where T : DataServiceable {
        let body = try! JSONEncoder().encode(object)
        let path = object.pathComponents
        self.init(body: body, method: method, path: path)
    }
}
