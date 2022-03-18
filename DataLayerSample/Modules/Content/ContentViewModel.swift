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
    @Published private var content: Content?
    @ObservedObject private var service: DataService<Content>
    let didTapUpdate: PassthroughSubject<Void, Never>
    var cancellables: Set<AnyCancellable>!
    
    init(contentId: Content.ID, data: DataManager) {
        self.contentId = contentId
        self.service = data.contentData
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
    
    private func updateContent() {
        let contentsById = service.objectsById
        guard var content = contentsById[contentId] else { return }
        content.text = "ayo, \(content.text)"
        service.update(content)
    }
}
