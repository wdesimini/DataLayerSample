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
            if let coordinator = ContentCoordinator() {
                ContentCoordinatorView(
                    coordinator: coordinator
                )
            } else {
                Text("(no content)")
            }
        }
    }
}
