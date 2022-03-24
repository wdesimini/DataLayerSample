//
//  DataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 1/9/22.
//

import Foundation

protocol DataSource {
    typealias Path = [String]
    typealias Handler = () -> Void
    typealias ErrorHandler = (Error?) -> Void
    typealias ReadHandler = (Result<Data?, Error>) -> Void
    func create(
        _ data: Data,
        at path: Path,
        completion: @escaping Handler
    )
    func delete(
        at path: Path,
        completion: @escaping ErrorHandler
    )
    func read(
        at path: Path,
        completion: @escaping ReadHandler
    )
    func register(
        type: String,
        completion: @escaping ErrorHandler
    )
    func update(
        _ data: Data,
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
