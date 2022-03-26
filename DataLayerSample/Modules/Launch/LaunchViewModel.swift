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

class LaunchViewModel: LaunchViewModelInput {
    let launchViewDidAppear: PassthroughSubject<Void, Never>
    weak var coordinator: LaunchCoordinatorInput?
    private var cancellables: Set<AnyCancellable>
    @ObservedObject private var model: DataService<Content>
    
    init(data: DataManager) {
        self.cancellables = .init()
        self.launchViewDidAppear = .init()
        self.model = data.contentData
        self.bind()
    }
    
    private func bind() {
        weak var welf = self
        model.$objectsById
            .sink { _ in welf?.coordinator?.stopLaunch() }
            .store(in: &cancellables)
        launchViewDidAppear
            .sink { welf?.model.loadLaunchData() }
            .store(in: &cancellables)
    }
    
    // MARK: LaunchViewModelInput
    
    var launchViewMessage: String {
        "launching application..."
    }
}
