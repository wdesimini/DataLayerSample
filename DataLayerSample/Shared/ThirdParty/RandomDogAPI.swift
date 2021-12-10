//
//  RandomDogAPI.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/10/21.
//

import Foundation

class RandomDogAPI {
    typealias Handler = (Dog?) -> Void
    
    static var queryURL: URL {
        URL(string: "https://random.dog/woof.json")!
    }
    
    static func woof(retry: Bool = true, completion: @escaping Handler) {
        let task = execute(completion:)
        if retry {
            RandomDogAPI.retry(task, completion: completion)
        } else {
            task(completion)
        }
    }
    
    private static func dog(fromData data: Data) -> Dog? {
        let decoder = JSONDecoder()
        let dog = try? decoder.decode(Dog.self, from: data)
        let fileURL = dog?.url.lastPathComponent
        let isMP4 = fileURL?.hasSuffix(".mp4") ?? false
        return isMP4 ? nil : dog
    }
    
    private static func execute(completion: @escaping Handler) {
        let session = URLSession.shared
        let task = session.dataTask(with: queryURL) { (data, _, _) in
            let dog = data.flatMap(dog(fromData:))
            DispatchQueue.main.async {
                completion(dog)
            }
        }
        task.resume()
    }
    
    private static func retry(
        _ task: @escaping (@escaping Handler) -> Void,
        completion: @escaping Handler
    ) {
        task {
            if let _ = $0 {
                completion($0)
            } else {
                retry(task, completion: completion)
            }
        }
    }
}
