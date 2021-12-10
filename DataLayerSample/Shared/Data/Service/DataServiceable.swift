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

extension DataServiceable {
    static var directoryTitle: String {
        .init(describing: self)
    }
    
    static func pathComponents(id: Self.ID) -> [String] {
        let idString = string(fromId: id)
        return [Self.directoryTitle, idString]
    }
    
    var pathComponents: [String] {
        Self.pathComponents(id: id)
    }
}

extension DataServiceable where Self.ID == UUID {
    static func string(fromId id: UUID) -> String {
        id.uuidString
    }
}

extension DataServiceable where Self.ID == URL {
    static func string(fromId id: URL) -> String {
        id.absoluteString
    }
}
