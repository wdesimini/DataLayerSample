//
//  Button+Willy.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import SwiftUI
import Combine

extension Button {
    init(
        action: PassthroughSubject<Void, Never>,
        @ViewBuilder label: () -> Label
    ) {
        self.init(
            action: { action.send(()) },
            label: label
        )
    }
}

extension Button where Label == Text {
    init(
        _ text: String,
        action: PassthroughSubject<Void, Never>
    ) {
        self.init(
            text,
            action: { action.send(()) }
        )
    }
}
