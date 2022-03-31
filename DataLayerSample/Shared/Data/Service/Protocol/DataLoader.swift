//
//  DataLoader.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

protocol DataLoader: DataServicer {
    func load(objectWithId id: T.ID)
}
