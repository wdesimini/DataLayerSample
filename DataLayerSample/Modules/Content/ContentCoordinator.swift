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
    DebugClass,
    ObservableObject
{
    let viewModel: ContentViewModel
    private let data: DataManager
    @Published var sheetState: SheetState?
    private(set) var contentChildCoordinator: ContentChildCoordinator?

    init(
        contentId: Content.ID,
        data: DataManager
    ) {
        self.data = data
        self.viewModel = .init(contentId: contentId, model: data)
        super.init()
        self.viewModel.coordinator = self
    }

    func onSheetDismiss() {
        contentChildCoordinator = nil
        sheetState = nil
    }
}

// MARK: ContentCoordinatorInput

extension ContentCoordinator: ContentCoordinatorInput {
    func showChild(contentChildId: ContentChild.ID) {
        contentChildCoordinator =
        ContentChildCoordinator(
            contentChildId: contentChildId,
            data: data,
            parent: self
        )
        sheetState = .childContent
    }
}

// MARK: ContentChildCoordinatorParent

extension ContentCoordinator: ContentChildCoordinatorParent {
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
