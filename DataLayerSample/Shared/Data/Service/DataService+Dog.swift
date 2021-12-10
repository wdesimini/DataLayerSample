//
//  DataService+Dog.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/10/21.
//

import Foundation

extension DataService where T == Dog {
    typealias Handler = (Dog?) -> Void
    
    func newPupper(completion: @escaping Handler) {
        RandomDogAPI.woof { [weak self] dog in
            dog.flatMap { self?.create($0) }
            completion(dog)
        }
    }
}
