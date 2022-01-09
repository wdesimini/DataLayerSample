//
//  DataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

class DataService<T: DataServiceable>: ObservableObject {
    let source: DataSource
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
}

// MARK: - Mock Data

extension DataService {
    enum MockDataError: Error {
        case mockFileNotFound
    }

    private static var mockFilename: String {
        "Mock" + String(describing: T.self)
    }

    func createMockData() throws {
        let data = try mockData()
        let mock = try decoder.decode(T.self, from: data)
        create(mock)
    }

    func mockData() throws -> Data {
        let bundle = Bundle.main
        let filename = Self.mockFilename
        let filePath = bundle.path(forResource: filename, ofType: "json")
        guard let path = filePath else { throw MockDataError.mockFileNotFound }
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }
}
