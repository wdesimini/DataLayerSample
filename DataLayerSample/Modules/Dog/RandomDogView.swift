//
//  DogView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import SwiftUI

struct DogView: View {
    @ObservedObject var viewModel: RandomDogViewModel
    
    var body: some View {
        VStack(spacing: 27) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            Button("New Pupper", action: viewModel.newPupper)
        }
    }
    
    private var image: UIImage {
        let data = viewModel.randomDogImageData
        let image = data.flatMap(UIImage.init(data:))
        return image ?? UIImage()
    }
}

struct RandomDogView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let randomDog = data.randomDogData.objectsById.values.first!
        let viewModel = RandomDogViewModel(data: data, randomDog: randomDog)
        return DogView(viewModel: viewModel)
    }
}
