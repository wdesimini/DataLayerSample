//
//  ContentModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

protocol ContentModelInput: DataServicer
where T == Content {
    func updateContent(id: Content.ID)
}

extension DataService: ContentModelInput where T == Content {
    func updateContent(id: Content.ID) {
        guard var content = read(objectWithId: id) else {
            return
        }
        content.text = "ayo, \(content.text)"
        update(content)
    }
}
