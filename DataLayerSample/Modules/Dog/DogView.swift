//
//  DogView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import SwiftUI

struct DogView: View {
    @ObservedObject var viewModel: DogViewModel
    
    var body: some View {
        VStack(spacing: 27) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
    
    private var image: UIImage {
        let data = viewModel.randomDogImageData
        let image = data.flatMap(UIImage.init(data:))
        return image ?? UIImage()
    }
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let dog = data.dogData.objectsById.values.first!
        let dogUrl = dog.url
        let viewModel = DogViewModel(data: data, dogUrl: dogUrl)
        return DogView(viewModel: viewModel)
    }
}
