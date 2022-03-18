//
//  Content.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import Foundation

struct Content: DataServiceable {
    let id: UUID
    var childContentId: ContentChild.ID?
    var text: String
}
