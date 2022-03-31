//
//  DataServicer.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

protocol DataServicer: ObservableObject {
    associatedtype T: DataServiceable
    var objectPublisher: Published<[T.ID: T]>.Publisher { get }
    func create(_ object: T)
    func read(objectWithId id: T.ID) -> T?
    func delete(_ object: T)
    func update(_ object: T)
}
