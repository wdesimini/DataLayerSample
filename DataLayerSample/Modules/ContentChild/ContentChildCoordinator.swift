//
//  ContentChildCoordinator.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import Combine
import SwiftUI

// MARK: logic

protocol ContentChildCoordinatorInput: AnyObject {
    func stopChildContent()
}

protocol ContentChildCoordinatorParent: AnyObject {
    func dismissChildContent()
}

class ContentChildCoordinator:
    ContentChildCoordinatorInput,
    ObservableObject
{
    typealias ViewModelType =
    ContentChildViewModel<DataService<ContentChild>>

    let viewModel: ViewModelType
    unowned let parent: ContentChildCoordinatorParent?

    init(
        contentChildId: ContentChild.ID,
        data: DataManager,
        parent: ContentChildCoordinatorParent?
    ) {
        self.viewModel = .init(
            contentChildId: contentChildId,
            service: data.contentChildData
        )
        self.parent = parent
        self.viewModel.coordinator = self
    }

    // MARK: ContentChildCoordinatorInput

    func stopChildContent() {
        parent?.dismissChildContent()
    }
}

// MARK: interface

struct ContentChildCoordinatorView: View {
    @ObservedObject var coordinator: ContentChildCoordinator

    var body: some View {
        ContentChildView(
            viewModel: coordinator.viewModel
        )
    }
}
