//
//  RandomDogViewModel.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import Foundation

class RandomDogViewModel: ObservableObject {
    private let data: DataManager
    @Published private var dogUrl: URL?
    
    init(data: DataManager) {
        self.data = data
    }
    
    var dogViewModel: DogViewModel? {
        guard let url = dogUrl else { return nil }
        let dog = data.dogData.read(objectWithId: url)
        return dog.flatMap { .init(data: data, dogUrl: $0.url) }
    }
    
    func newPupperTapped() {
        data.dogData.newPupper { [weak self] dog in
            self?.dogUrl = dog?.url
        }
    }
}
