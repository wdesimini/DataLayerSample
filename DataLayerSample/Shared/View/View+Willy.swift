//
//  View+Willy.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import Combine
import SwiftUI

extension View {
    func sheet<Content>(
        isPresented: Binding<Bool>,
        onDismissAction: PassthroughSubject<Void, Never>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        sheet(
            isPresented: isPresented,
            onDismiss: { onDismissAction.send(()) },
            content: content
        )
    }
}
