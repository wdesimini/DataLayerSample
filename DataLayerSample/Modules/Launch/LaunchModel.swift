//
//  LaunchModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import Foundation

protocol LaunchModelInput: AnyObject {
    func loadLaunchData()
}

extension DataService: LaunchModelInput where T == Content {
    func loadLaunchData() {
        guard let contentId = objectsById.keys.first,
              let content = objectsById[contentId] else {
            return
        }
        update(content)
    }
}
