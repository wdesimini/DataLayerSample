//
//  LaunchViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import Combine
import SwiftUI

protocol LaunchViewModelInput: ObservableObject {
    var launchViewDidAppear: PassthroughSubject<Void, Never> { get }
    var launchViewMessage: String { get }
}

class LaunchViewModel<ModelType>:
    DebugClass,
    LaunchViewModelInput
where ModelType: LaunchModelInput
{
    let launchViewDidAppear: PassthroughSubject<Void, Never>
    weak var coordinator: LaunchCoordinatorInput?
    private var cancellables: Set<AnyCancellable>
    @ObservedObject private var model: ModelType

    init(model: ModelType) {
        self.cancellables = .init()
        self.launchViewDidAppear = .init()
        self.model = model
        super.init()
        self.bind()
    }

    private func bind() {
        weak var welf = self
        launchViewDidAppear
            .sink { welf?.loadLaunchData() }
            .store(in: &cancellables)
    }

    private func loadLaunchData() {
        #warning("tbd - add launching logic")
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1
        ) {
            self.coordinator?.stopLaunch()
        }
    }

    // MARK: LaunchViewModelInput

    var launchViewMessage: String {
        "launching application..."
    }
}
