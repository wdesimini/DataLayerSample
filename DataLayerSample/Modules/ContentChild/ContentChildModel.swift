//
//  ContentChildModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Foundation

protocol ContentChildModelInput:
    DataServicer
where T == ContentChild {
}

extension DataService: ContentChildModelInput
where T == ContentChild {
    
}
