//
//  ContentViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Combine
import SwiftUI

protocol ContentViewModelInput: ObservableObject {
    var contentText: String { get }
    var didTapShowChild: PassthroughSubject<Void, Never> { get }
    var didTapUpdate: PassthroughSubject<Void, Never> { get }
}

class ContentViewModel<ModelType>: ContentViewModelInput
where ModelType: ContentModelInput {
    private let contentId: Content.ID
    @Published private var content: Content?
    @ObservedObject private var service: ModelType
    let didTapShowChild: PassthroughSubject<Void, Never>
    let didTapUpdate: PassthroughSubject<Void, Never>
    var cancellables: Set<AnyCancellable>!
    weak var coordinator: ContentCoordinatorInput?
    
    init(contentId: Content.ID, service: ModelType) {
        self.contentId = contentId
        self.service = service
        self.didTapShowChild = PassthroughSubject()
        self.didTapUpdate = PassthroughSubject()
        self.bind()
    }
    
    private func bind() {
        cancellables = .init()
        weak var welf = self
        service.objectPublisher
            .sink { welf?.didReceive(contentById: $0) }
            .store(in: &cancellables)
        didTapShowChild
            .sink { welf?.showContentChild() }
            .store(in: &cancellables)
        didTapUpdate
            .sink { welf?.updateContent() }
            .store(in: &cancellables)
    }
    
    var contentText: String {
        content?.text ?? "(none)"
    }
    
    private func didReceive(contentById: [Content.ID: Content]) {
        content = contentById[contentId]
    }
    
    private func updateContent() {
        service.updateContent(id: contentId)
    }
    
    private func showContentChild() {
        if let id = content?.childContentId {
            coordinator?.showChild(contentChildId: id)
        }
    }
}
