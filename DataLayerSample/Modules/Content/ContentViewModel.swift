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

class ContentViewModel: ContentViewModelInput {
    private let contentId: Content.ID
    @Published private var content: Content?
    @ObservedObject private var service: DataService<Content>
    let didTapShowChild: PassthroughSubject<Void, Never>
    let didTapUpdate: PassthroughSubject<Void, Never>
    var cancellables: Set<AnyCancellable>!
    weak var coordinator: ContentCoordinatorInput?
    
    init(contentId: Content.ID, data: DataManager) {
        self.contentId = contentId
        self.service = data.contentData
        self.didTapShowChild = PassthroughSubject()
        self.didTapUpdate = PassthroughSubject()
        self.bind()
    }
    
    private func bind() {
        cancellables = .init()
        weak var welf = self
        service.$objectsById
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
        let contentsById = service.objectsById
        guard var content = contentsById[contentId] else { return }
        content.text = "ayo, \(content.text)"
        service.update(content)
    }
    
    private func showContentChild() {
        if let id = content?.childContentId {
            coordinator?.showChild(contentChildId: id)
        }
    }
}
