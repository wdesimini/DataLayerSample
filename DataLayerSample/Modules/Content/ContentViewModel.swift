//
//  ContentViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    private let contentId: Content.ID
    @Published var isShowingChild = false
    @Published private var content: Content?
    @ObservedObject private var service: DataService<Content>
    let didDismissChild: PassthroughSubject<Void, Never>
    let didTapShowChild: PassthroughSubject<Void, Never>
    let didTapUpdate: PassthroughSubject<Void, Never>
    var cancellables: Set<AnyCancellable>!
    
    init(contentId: Content.ID, data: DataManager) {
        self.contentId = contentId
        self.service = data.contentData
        self.didDismissChild = PassthroughSubject()
        self.didTapShowChild = PassthroughSubject()
        self.didTapUpdate = PassthroughSubject()
        self.bind()
    }
    
    private func bind() {
        cancellables = .init()
        service.$objectsById
            .sink { [weak self] in
                self?.didReceive(contentById: $0)
            }
            .store(in: &cancellables)
        didDismissChild
            .sink { [weak self] _ in
                self?.isShowingChild = false
            }
            .store(in: &cancellables)
        didTapShowChild
            .sink { [weak self] _ in
                self?.showChild()
            }
            .store(in: &cancellables)
        didTapUpdate
            .sink { [weak self] _ in
                self?.updateContent()
            }
            .store(in: &cancellables)
    }
    
    var contentText: String {
        content?.text ?? "(none)"
    }
    
    private func didReceive(contentById: [Content.ID: Content]) {
        content = contentById[contentId]
    }
    
    private func showChild() {
        isShowingChild = true
    }
    
    private func updateContent() {
        let contentsById = service.objectsById
        guard var content = contentsById[contentId] else { return }
        content.text = "ayo, \(content.text)"
        service.update(content)
    }
}
