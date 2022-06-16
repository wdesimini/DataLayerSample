//
//  DataLayerSampleAppCoordinator.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import Foundation

enum DataLayerSampleAppState: String, Identifiable {
    case none, launch, content
    var id: String { rawValue }
}

class DataLayerSampleAppCoordinator:
    ObservableObject,
    LaunchCoordinatorOutput
{
    private let data: DataManager
    private(set) var childCoordinator: AnyObject?
    @Published private(set) var state: DataLayerSampleAppState

    init() {
        data = .shared
        state = .none
        showLaunch()
    }

    var contentCoordinator: ContentCoordinator? {
        childCoordinator as? ContentCoordinator
    }

    var launchCoordinator: LaunchCoordinator? {
        childCoordinator as? LaunchCoordinator
    }

    private func showLaunch() {
        childCoordinator =
        LaunchCoordinator(data: data, output: self)
        state = .launch
    }

    private func showContent(
        withId contentId: Content.ID?
    ) {
        if let contentId = contentId {
            childCoordinator =
            ContentCoordinator(
                contentId: contentId, data: data
            )
            state = .content
        } else {
            state = .none
        }
    }

    // MARK: LaunchCoordinatorOutput

    func resignLaunch() {
        childCoordinator = nil
        let contentId =
        data.contentData.objectsById.keys.first
        showContent(withId: contentId)
    }
}
