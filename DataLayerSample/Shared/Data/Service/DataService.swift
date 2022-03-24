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
    typealias ReadHandler = (Result<T?, Error>) -> Void
    
    fileprivate let source: DataSource
    @Published private(set) var objectsById = [T.ID: T]()
    
    init(source: DataSource) {
        self.source = source
    }
    
    func create(_ object: T) {
        objectsById[object.id] = object
        guard let data = DataParser.serialize(object) else {
            return
        }
        let path = object.pathComponents
        source.create(data, at: path) {
        }
    }
    
    func delete(_ object: T) {
        objectsById.removeValue(forKey: object.id)
        let path = object.pathComponents
        source.delete(at: path) { _ in
        }
    }
    
    func load(
        objectWithId id: T.ID,
        completion: ReadHandler? = nil
    ) {
        let group = DispatchGroup()
        var result: Result<T?, Error> = .success(nil)
        if let object = read(objectWithId: id) {
            result = .success(object)
        } else {
            group.enter()
            let path = T.pathComponents(id: id)
            source.read(at: path) {
                switch $0 {
                case .success(let data):
                    result = .success(
                        data.flatMap(DataParser.parse(_:))
                    )
                case .failure(let error):
                    result = .failure(error)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if let object = try? result.get() {
                self.objectsById[object.id] = object
            }
            completion?(result)
        }
    }
    
    func read(objectWithId id: T.ID) -> T? {
        objectsById[id]
    }
    
    func update(_ object: T) {
        objectsById[object.id] = object
        guard let data = DataParser.serialize(object) else {
            return
        }
        let path = object.pathComponents
        source.update(data, at: path) { _ in
        }
    }
}

// MARK: MockDataServicer

extension DataService: MockDataServicer {
    private static var mockFilename: String {
        "Mock" + String(describing: T.self)
    }

    func createMockData() throws {
        let data = try mockData()
        let mock: T? = DataParser.parse(data)
        guard let mock = mock else { return }
        create(mock)
    }

    func mockData() throws -> Data {
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
