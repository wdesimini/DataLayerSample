//
//  DataService+Mock.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Foundation

extension DataService {
    enum MockDataError: Error {
        case mockFileNotFound
    }

    private static var mockFilename: String {
        "Mock" + String(describing: T.self)
    }

    func createMockData() throws {
        let data = try mockData()
        let mock = try JSONDecoder().decode(T.self, from: data)
        create(mock)
    }

    func mockData() throws -> Data {
        let filename = Self.mockFilename
        let filePath = Bundle.main.path(forResource: filename, ofType: "json")
        guard let path = filePath else { throw MockDataError.mockFileNotFound }
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }
}
