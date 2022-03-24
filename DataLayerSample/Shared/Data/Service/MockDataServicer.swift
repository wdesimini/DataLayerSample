//
//  MockDataServicer.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/24/22.
//

import Foundation

protocol MockDataServicer: MockDataCreator {
    associatedtype DataType: DataServiceable
    var mockObject: DataType { get }
}

enum MockDataError: Error {
    case mockFileNotFound
}

extension MockDataServicer {
    func mockData(
        bundle: Bundle,
        filename: String,
        filetype: String
    ) throws -> Data {
        let filePath = bundle.path(
            forResource: filename, ofType: filetype
        )
        guard let path = filePath else {
            throw MockDataError.mockFileNotFound
        }
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }
}
