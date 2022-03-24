//
//  DataParser.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/24/22.
//

import Foundation

/// wrap serialization-related errors
/// with decoding/enoding objects
struct DataParser {
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    static func parse<T: Decodable>(_ data: Data) -> T? {
        let object: T?
        do {
            object = try decoder.decode(T.self, from: data)
        } catch {
            object = nil
            print(error.localizedDescription)
        }
        return object
    }
    
    static func serialize<T: Encodable>(_ object: T) -> Data? {
        let data: Data?
        do {
            data = try encoder.encode(object)
        } catch {
            data = nil
            print(error.localizedDescription)
        }
        return data
    }
}
