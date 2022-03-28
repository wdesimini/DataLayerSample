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
        #warning("simulating load time")
        DispatchQueue.global().asyncAfter(
            deadline: .now() + 2
        ) {
            guard let contentId = self.objectsById.keys.first,
                  let content = self.objectsById[contentId] else {
                return
            }
            DispatchQueue.main.async {
                self.update(content)
            }
        }
    }
}
