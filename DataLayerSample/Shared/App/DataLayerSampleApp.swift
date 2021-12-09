//
//  DataLayerSampleApp.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import SwiftUI

@main
struct DataLayerSampleApp: App {
    private let data = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            if let viewModel = contentViewModel {
                ContentView(viewModel: viewModel)
            } else {
                Text("(no content)")
            }
        }
    }
    
    var contentViewModel: ContentViewModel? {
        let contents = data.contentData.objectsById.values
        guard let contentId = contents.first?.id else { return nil }
        return ContentViewModel(contentId: contentId, data: data)
    }
}
