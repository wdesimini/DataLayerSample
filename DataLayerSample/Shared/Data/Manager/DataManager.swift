//
//  DataManager.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Foundation

class DataManager {
    static let preview = DataManager(preview: true)
    static let shared = DataManager()
    
    let dogData = DataService<Dog>()
    let imageData = ImageDataService()
    
    private init(preview: Bool = false) {
        preview ? loadPreviewData() : ()
    }
    
    private func loadPreviewData() {
        try! dogData.createMockData()
    }
    
    func register() throws {
        #warning("tbd - should probably move this...")
        try dogData.register()
    }
}
