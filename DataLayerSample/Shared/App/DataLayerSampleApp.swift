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
    private let randomDogViewModel = RandomDogViewModel(data: .shared)
    
    var body: some Scene {
        WindowGroup {
            RandomDogView(viewModel: randomDogViewModel)
                .padding()
        }
    }
}
