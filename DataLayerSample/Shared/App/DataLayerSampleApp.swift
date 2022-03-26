//
//  DataLayerSampleApp.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import SwiftUI

@main
struct DataLayerSampleApp: App {
    @ObservedObject var coordinator = DataLayerSampleAppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            switch coordinator.state {
            case .none:
                EmptyView()
            case .launch:
                if let launchCoordinator =
                    coordinator.launchCoordinator
                {
                    LaunchCoordinatorView(
                        coordinator: launchCoordinator
                    )
                }
            case .content:
                if let contentCoordinator =
                    coordinator.contentCoordinator
                {
                    ContentCoordinatorView(
                        coordinator: contentCoordinator
                    )
                }
            }
            EmptyView()
        }
    }
}
