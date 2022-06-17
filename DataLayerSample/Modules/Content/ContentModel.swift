//
//  ContentModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/28/22.
//

import Combine

protocol ContentModelInput: AnyObject {
    func subscribeToContent(
        withId contentId: Content.ID,
        through subject: PassthroughSubject<Content, Never>
    ) -> AnyCancellable
    func updateContent(id: Content.ID)
}

extension DataManager: ContentModelInput {
    func subscribeToContent(
        withId contentId: Content.ID,
        through subject: PassthroughSubject<Content, Never>
    ) -> AnyCancellable {
        contentData
            .$objectsById
            .compactMap { $0[contentId] }
            .subscribe(subject)
    }
    
    func updateContent(id: Content.ID) {
        let content = contentData.read(objectWithId: id)
        guard var content else { return }
        content.text = "ayo, \(content.text)"
        contentData.update(content)
    }
}
