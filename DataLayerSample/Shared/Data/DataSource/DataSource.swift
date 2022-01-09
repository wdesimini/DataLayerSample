//
//  DataSource.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 1/9/22.
//

import Foundation

protocol DataSource {
    typealias Path = [String]
    func create(_ data: Data, at path: Path)
    func delete(at path: Path) throws
    func read(at path: Path) throws -> Data?
    func register(type: String) throws
    func update(_ data: Data, at path: Path) throws
}
