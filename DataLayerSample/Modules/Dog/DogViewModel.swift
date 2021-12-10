//
//  DogViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import Combine
import SwiftUI

class DogViewModel: ObservableObject {
    private let dogUrl: URL
    @ObservedObject private var imageData: ImageDataService
    private var imageDataObserver: AnyCancellable?
    @Published private(set) var randomDogImageData: Data?
    
    init(data: DataManager, dogUrl: URL) {
        self.imageData = data.imageData
        self.dogUrl = dogUrl
        let publisher = imageData.$imageDataByURL
        let received = didReceive(imageDataByURL:)
        imageDataObserver = publisher.sink(receiveValue: received)
        imageData.imageData(url: dogUrl)
    }
    
    private func didReceive(imageDataByURL: [URL: Data]) {
        randomDogImageData = imageDataByURL[dogUrl]
    }
}
