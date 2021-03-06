//
//  LaunchCoordinator.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import Combine
import SwiftUI

protocol LaunchCoordinatorInput: AnyObject {
    func stopLaunch()
}

protocol LaunchCoordinatorOutput: AnyObject {
    func resignLaunch()
}

class LaunchCoordinator:
    DebugClass,
    LaunchCoordinatorInput,
    ObservableObject
{
    let viewModel: LaunchViewModel<DataService<Content>>
    unowned let output: LaunchCoordinatorOutput?

    init(
        data: DataManager,
        output: LaunchCoordinatorOutput? = nil
    ) {
        self.output = output
        self.viewModel = .init(model: data.contentData)
        super.init()
        self.viewModel.coordinator = self
    }

    func stopLaunch() {
        output?.resignLaunch()
    }
}

struct LaunchCoordinatorView: View {
    @ObservedObject var coordinator: LaunchCoordinator

    var body: some View {
        LaunchView(
            viewModel: coordinator.viewModel
        )
    }
}
