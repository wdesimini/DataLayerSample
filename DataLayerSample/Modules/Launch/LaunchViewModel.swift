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

class LaunchViewModel<
    ModelType: LaunchModelInput
>: LaunchViewModelInput {
    let launchViewDidAppear: PassthroughSubject<Void, Never>
    weak var coordinator: LaunchCoordinatorInput?
    private var cancellables: Set<AnyCancellable>
    @ObservedObject private var model: ModelType
    
    init(model: ModelType) {
        self.cancellables = .init()
        self.launchViewDidAppear = .init()
        self.model = model
        self.bind()
    }
    
    private func bind() {
        weak var welf = self
        model.objectPublisher
            .sink { _ in welf?.coordinator?.stopLaunch() }
            .store(in: &cancellables)
        launchViewDidAppear
            .sink { welf?.loadLaunchData() }
            .store(in: &cancellables)
    }
    
    private func loadLaunchData() {
        model.loadInitialContent()
    }
    
    // MARK: LaunchViewModelInput
    
    var launchViewMessage: String {
        "launching application..."
    }
}
