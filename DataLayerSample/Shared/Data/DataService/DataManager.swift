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
    
    let contentData = DataService<Content>()
    
    private init(preview: Bool = false) {
        preview ? loadPreviewData() : ()
    }
    
    private func loadPreviewData() {
        try! contentData.createMockData()
    }
}
