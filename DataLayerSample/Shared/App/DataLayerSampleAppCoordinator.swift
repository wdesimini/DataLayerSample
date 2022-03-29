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
        var manager = DataManager.shared
        #if DEBUG
        manager = DataManager.preview
        #endif
        data = manager
        state = .none
        showLaunch()
    }
    
    var launchCoordinator: LaunchCoordinator? {
        childCoordinator as? LaunchCoordinator
    }
    
    var contentCoordinator: ContentCoordinator? {
        childCoordinator as? ContentCoordinator
    }
    
    
    private func showLaunch() {
        childCoordinator =
        LaunchCoordinator(data: data, output: self)
        state = .launch
    }
    
    private func showContent() {
        let contentId =
        data.contentData.objectsById.keys.first!
        childCoordinator =
        ContentCoordinator(contentId: contentId, data: data)
        state = .content
    }
    
    // MARK: LaunchCoordinatorOutput
    
    func resignLaunch() {
        childCoordinator = nil
        showContent()
    }
}
