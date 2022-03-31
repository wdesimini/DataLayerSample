//
//  LaunchModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import Foundation

protocol LaunchModelInput: DataLoader
where T == Content {
}

extension DataService: LaunchModelInput
where T == Content {
}
