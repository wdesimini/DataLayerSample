//
//  ContentCoordinator.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import Combine
import SwiftUI

// MARK: logic

class ContentCoordinator: ObservableObject {
    let viewModel: ContentViewModel
    @Published var sheetIsPresented = false
    
    init?() {
        let data = DataManager.shared
        let contentIds = data.contentData.objectsById.keys
        guard let contentId = contentIds.first else { return nil }
        viewModel = ContentViewModel(contentId: contentId, data: data)
        viewModel.coordinator = self
    }
    
    func showChild() {
        sheetIsPresented = true
    }
    
    func onSheetDismiss() {
    }
}

// MARK: interface

struct ContentCoordinatorView: View {
    @ObservedObject var coordinator: ContentCoordinator
    
    var body: some View {
        ContentView(
            viewModel: coordinator.viewModel
        )
        .sheet(
            isPresented: $coordinator.sheetIsPresented,
            onDismiss: coordinator.onSheetDismiss,
            content: sheetView
        )
    }
    
    @ViewBuilder
    private func sheetView() -> some View {
        DeferView {
            Text(
                coordinator.viewModel.contentText
            )
        }
    }
}
