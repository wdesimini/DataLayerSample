//
//  DeferView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import SwiftUI

/*
 lazily creates view to prevent multiple
 view initializations from presentation modifiers
 like .sheet or .fullScreenCover
 */

struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
    }
}
