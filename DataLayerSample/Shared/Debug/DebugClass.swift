//
//  DebugClass.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 6/15/22.
//

import Foundation

#if DEBUG
class DebugClass {
    static var instanceCountByTypeDescription = [String: Int]()
    static var typeDescription: String {
        .init(describing: Self.self)
    }

    init() {
        let typeDescription = Self.typeDescription
        Self.instanceCountByTypeDescription[typeDescription, default: 0] += 1
        let instanceCount = Self.instanceCountByTypeDescription[typeDescription, default: 0]
        print("\(typeDescription) init - \(instanceCount)")
    }

    deinit {
        let typeDescription = Self.typeDescription
        Self.instanceCountByTypeDescription[typeDescription, default: 0] -= 1
        let instanceCount = Self.instanceCountByTypeDescription[typeDescription, default: 0]
        print("\(typeDescription) deinit - \(instanceCount)")
    }
}
#else
class DebugClass {}
#endif
