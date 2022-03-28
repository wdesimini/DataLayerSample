//
//  LaunchModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import Foundation

protocol LaunchModelInput: DataLoader
where T == Content {
    func loadInitialContent()
}

extension DataService: LaunchModelInput
where T == Content {
    func loadInitialContent() {
        guard let contentId = objectsById.keys.first else {
            return
        }
        load(objectWithId: contentId)
    }
}
