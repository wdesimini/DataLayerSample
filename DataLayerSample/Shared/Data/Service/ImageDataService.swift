//
//  ImageDataService.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import Foundation

class ImageDataService: ObservableObject {
    typealias Handler = (Data?) -> Void
    @Published private(set) var imageDataByURL = [URL: Data]()
    
    func imageData(url: URL) {
        guard imageDataByURL[url] == nil else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self ] (data, _, _) in
            DispatchQueue.main.async {
                self?.imageDataByURL[url] = data
            }
        }
        task.resume()
    }
}
