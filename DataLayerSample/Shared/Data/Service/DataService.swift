//
//  DataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

class DataService<T: DataServiceable> {
    typealias Handler = () -> Void
    typealias ErrorHandler = (Error?) -> Void
    typealias LoadHandler = (Result<T?, Error>) -> Void
    
    let source: DataSource
    @Published private(set) var objectsById = [T.ID: T]()
    
    init(source: DataSource) {
        self.source = source
    }
}

// MARK: DataLoader

extension DataService: DataLoader {
    func load(objectWithId id: T.ID) {
        let path = T.pathComponents(id: id)
        source.loadData(at: path) {
            [weak self] in
            switch $0 {
            case .success(let data):
                let object: T? =
                data.flatMap(DataParser.parse(_:))
                object.flatMap {
                    self?.objectsById[$0.id] = $0
                }
            case .failure(let error):
                #warning("tbd - handle data loading failure")
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: DataServicer

extension DataService: DataServicer {
    var objectPublisher: Published<[T.ID : T]>.Publisher {
        $objectsById
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
    
    private func save(
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

    func mockData() throws -> Data {
        try mockData(
            bundle: .main,
            filename: Self.mockFilename,
            filetype: "json"
        )
    }
}

// MARK: DataRegistrar

extension DataService: DataRegistrar {
    func register(completion: @escaping ErrorHandler) {
        let type = T.directoryTitle
        source.register(
            type: type,
            completion: completion
        )
    }
}
