//
//  DataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 1/9/22.
//

import Foundation

protocol DataSource {
    typealias Path = [String]
    typealias ErrorHandler = (Error?) -> Void
    typealias LoadHandler = (Result<Data?, Error>) -> Void
    func register(
        type: String,
        completion: @escaping ErrorHandler
    )
    func loadData(
        at path: Path,
        completion: @escaping LoadHandler
    )
    func saveData(
        _ data: Data?,
        at path: Path,
        completion: @escaping ErrorHandler
    )
}

extension DataSource {
    func register(
        type: String,
        completion: @escaping ErrorHandler
    ) {
        completion(nil)
    }
}
