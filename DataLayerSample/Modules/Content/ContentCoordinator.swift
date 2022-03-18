//
//  ContentCoordinator.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import Combine
import SwiftUI

// MARK: logic

protocol ContentCoordinatorInput: AnyObject {
    func showChild(contentChildId: ContentChild.ID)
}

extension ContentCoordinator {
    enum SheetState: Identifiable {
        case childContent
        var id: SheetState { self }
    }
}

class ContentCoordinator:
    ContentCoordinatorInput,
    ContentChildCoordinatorParent,
    ObservableObject
{
    let viewModel: ContentViewModel
    private let data = DataManager.shared
    @Published var sheetState: SheetState?
    private(set) var contentChildCoordinator: ContentChildCoordinator?
    
    init?() {
        let contentIds = data.contentData.objectsById.keys
        guard let contentId = contentIds.first else { return nil }
        viewModel = ContentViewModel(contentId: contentId, data: data)
        viewModel.coordinator = self
    }
    
    func onSheetDismiss() {
        contentChildCoordinator = nil
        sheetState = nil
    }
    
    // MARK: ContentCoordinatorInput
    
    func showChild(contentChildId: ContentChild.ID) {
        contentChildCoordinator =
        ContentChildCoordinator(
            contentChildId: contentChildId,
            data: data,
            parent: self
        )
        sheetState = .childContent
    }
    
    // MARK: ContentChildCoordinatorParent
    
    func dismissChildContent() {
        onSheetDismiss()
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
            item: $coordinator.sheetState,
            onDismiss: coordinator.onSheetDismiss,
            content: sheetView
        )
    }
    
    @ViewBuilder
    private func sheetView(
        _ sheetState: ContentCoordinator.SheetState
    ) -> some View {
        DeferView {
            switch sheetState {
            case .childContent:
                ContentChildCoordinatorView(
                    coordinator: coordinator.contentChildCoordinator!
                )
            }
        }
    }
}
