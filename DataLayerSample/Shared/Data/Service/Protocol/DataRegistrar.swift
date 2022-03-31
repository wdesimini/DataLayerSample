//
//  DataRegistrar.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/24/22.
//

import Foundation

protocol DataRegistrar {
    typealias ErrorHandler = (Error?) -> Void
    func register(completion: @escaping ErrorHandler)
}
