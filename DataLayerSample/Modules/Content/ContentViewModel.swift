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
    @Published private(set) var contentText = "(none)"
    private var observer: AnyCancellable!
    @ObservedObject private var service: DataService<Content>
    
    init(contentId: Content.ID, data: DataManager) {
        self.contentId = contentId
        self.service = data.contentData
        self.observer = observe()
    }
    
    private func observe() -> AnyCancellable {
        service.$objectsById.sink { [weak self] in
            self?.didReceive(contentById: $0)
        }
    }
    
    private func didReceive(contentById: [Content.ID: Content]) {
        let content = contentById[contentId]
        contentText = content.map(\.text) ?? contentText
    }
}
