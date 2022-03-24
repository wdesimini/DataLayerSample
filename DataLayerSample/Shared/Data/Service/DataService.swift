//
//  DataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

class DataService<T: DataServiceable>: ObservableObject {
    typealias Handler = () -> Void
    typealias ErrorHandler = (Error?) -> Void
    typealias LoadHandler = (Result<T?, Error>) -> Void
    
    fileprivate let source: DataSource
    @Published private(set) var objectsById = [T.ID: T]()
    
    init(source: DataSource) {
        self.source = source
    }
    
    func create(_ object: T) {
        objectsById[object.id] = object
        save(object)
    }
    
    func delete(_ object: T) {
        objectsById.removeValue(forKey: object.id)
        let path = object.pathComponents
        source.saveData(nil, at: path) { _ in
        }
    }
    
    func read(objectWithId id: T.ID) -> T? {
        objectsById[id]
    }
    
    func update(_ object: T) {
        objectsById[object.id] = object
        save(object)
    }
    
    func load(
        objectWithId id: T.ID,
        completion: LoadHandler? = nil
    ) {
        let path = T.pathComponents(id: id)
        source.loadData(at: path) {
            let result: Result<T?, Error>
            switch $0 {
            case .success(let data):
                result = .success(
                    data.flatMap(DataParser.parse(_:))
                )
            case .failure(let error):
                result = .failure(error)
            }
            completion?(result)
        }
    }
    
    func save(
        _ object: T,
        completion: ErrorHandler? = nil
    ) {
        let group = DispatchGroup()
        var error: Error? = nil
        if let data = DataParser.serialize(object) {
            group.enter()
            let path = object.pathComponents
            source.saveData(data, at: path) {
                error = $0
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion?(error)
        }
    }
    
}

// MARK: MockDataServicer

extension DataService: MockDataServicer {
    private static var mockFilename: String {
        "Mock" + String(describing: T.self)
    }

    var mockObject: T {
        [T](objectsById.values).first!
    }
    
    func createMockData() throws {
        let data = try mockData()
        let mock: T? = DataParser.parse(data)
        guard let mock = mock else { return }
        create(mock)
    }

    private func mockData() throws -> Data {
        try mockData(
            bundle: .main,
            filename: Self.mockFilename,
            filetype: "json"
        )
    }
}

// MARK: RegisteredDataServicer

extension DataService: RegisteredDataServicer {
    func register(completion: @escaping ErrorHandler) {
        let type = T.directoryTitle
        source.register(
            type: type,
            completion: completion
        )
    }
}
