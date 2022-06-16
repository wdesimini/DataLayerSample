//
//  DataServiceable.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

protocol DataServiceable: Codable, Identifiable {
    static func string(fromId id: Self.ID) -> String
}

extension DataServiceable where Self.ID == UUID {
    static func string(fromId id: UUID) -> String {
        id.uuidString
    }
}

extension DataServiceable {
    static var directoryTitle: String {
        .init(describing: self)
    }

    static func pathComponents(id: Self.ID) -> [String] {
        [directoryTitle, string(fromId: id)]
    }

    var pathComponents: [String] {
        Self.pathComponents(id: id)
    }
}
