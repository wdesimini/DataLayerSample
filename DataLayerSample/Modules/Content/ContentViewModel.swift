//
//  ContentViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/2/21.
//

import Combine
import SwiftUI

// MARK: ViewModel

class ContentViewModel:
    DebugClass,
    ObservableObject
{
    weak var coordinator: ContentCoordinatorInput?
    private let contentId: Content.ID
    private let model: ContentModelInput
    private var bag: Set<AnyCancellable>
    @Published private var content: Content?
    
    init(
        contentId: Content.ID,
        model: ContentModelInput
    ) {
        self.bag = .init()
        self.contentId = contentId
        self.model = model
        super.init()
        self.bind()
    }
    
    private func bind() {
        weak var welf = self
        // create subject
        let subject =
        PassthroughSubject<Content, Never>()
        subject
            .sink { welf?.content = $0 }
            .store(in: &bag)
        // subscribe subject to data
        model
            .subscribeToContent(
                withId: contentId,
                through: subject)
            .store(in: &bag)
    }
}

// MARK: ViewModelInput

extension ContentViewModel {
    var contentText: String {
        content?.text ?? "(none)"
    }

    private var contentChildId: Content.ID? {
        content?.childContentId
    }

    func showChildContent() {
        guard let contentChildId else { return }
        coordinator?.showChild(contentChildId: contentChildId)
    }

    func updateContent() {
        model.updateContent(id: contentId)
    }
}
