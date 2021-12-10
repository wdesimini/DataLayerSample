//
//  Dog.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import Foundation

struct Dog: DataServiceable {
    let fileSizeBytes: Int
    let url: URL
    
    var id: URL {
        url
    }
}
