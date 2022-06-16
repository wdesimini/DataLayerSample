//
//  ContentChildViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import Combine
import SwiftUI

protocol ContentChildViewModelInput: ObservableObject {
    var contentChildText: String { get }
    var dismissPublisher: PassthroughSubject<Void, Never> { get }
}

class ContentChildViewModel<ModelType>:
    AppViewModel,
    ContentChildViewModelInput
where ModelType: ContentChildModelInput {
    let dismissPublisher: PassthroughSubject<Void, Never>
    private let contentChildId: ContentChild.ID
    weak var coordinator: ContentChildCoordinatorInput?
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject private var service: ModelType
    @Published private var contentChild: ContentChild?

    init(
        contentChildId: ContentChild.ID,
        service: ModelType
    ) {
        self.dismissPublisher = PassthroughSubject()
        self.contentChildId = contentChildId
        self.service = service
        super.init()
        self.bind()
    }

    var contentChildText: String {
        contentChild?.text ?? "(n/a)"
    }

    private func bind() {
        weak var welf = self
        dismissPublisher
            .sink { welf?.coordinator?.stopChildContent() }
            .store(in: &cancellables)
        service.objectPublisher
            .sink { welf?.didReceiveObjectsById($0) }
            .store(in: &cancellables)
    }

    private func didReceiveObjectsById(
        _ objectsById: [ContentChild.ID: ContentChild]
    ) {
        contentChild = objectsById[contentChildId]
    }
}
