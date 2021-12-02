//
//  DatabaseRequest.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Foundation

struct DatabaseRequest {
    let body: Data?
    let method: Method
    let path: [String]
    
    init(
        body: Data? = nil,
        method: Method,
        path: [String]
    ) {
        self.body = body
        self.method = method
        self.path = path
    }
}

extension DatabaseRequest {
    enum Method {
        case delete, get, patch, post
    }
}
