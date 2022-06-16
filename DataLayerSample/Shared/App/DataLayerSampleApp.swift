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
                coordinator.launchCoordinator
                    .flatMap(LaunchCoordinatorView.init)
            case .content:
                coordinator.contentCoordinator
                    .flatMap(ContentCoordinatorView.init)
            }
        }
    }
}
