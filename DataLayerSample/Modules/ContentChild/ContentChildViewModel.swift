//
//  ContentChildViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import Combine
import SwiftUI

class ContentChildViewModel: ObservableObject {
    let dismissPublisher: PassthroughSubject<Void, Never>
    private let contentChildId: ContentChild.ID
    weak var coordinator: ContentChildCoordinator!
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject private var service: DataService<ContentChild>
    @Published private var contentChild: ContentChild?
    
    init(
        contentChildId: ContentChild.ID,
        data: DataManager
    ) {
        self.dismissPublisher = PassthroughSubject()
        self.contentChildId = contentChildId
        self.service = data.contentChildData
        self.bind()
    }
    
    var contentChildText: String {
        contentChild?.text ?? "(n/a)"
    }
    
    private func bind() {
        weak var welf = self
        dismissPublisher
            .sink { welf?.coordinator.stopChildContent() }
            .store(in: &cancellables)
        service.$objectsById
            .sink { welf?.didReceiveObjectsById($0) }
            .store(in: &cancellables)
    }
    
    private func didReceiveObjectsById(
        _ objectsById: [ContentChild.ID: ContentChild]
    ) {
        contentChild = objectsById[contentChildId]
    }
}
