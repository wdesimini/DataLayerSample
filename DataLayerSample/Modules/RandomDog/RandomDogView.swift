//
//  RandomDogView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/9/21.
//

import SwiftUI

struct RandomDogView: View {
    @ObservedObject var viewModel: RandomDogViewModel
    
    var body: some View {
        VStack(spacing: 27) {
            viewModel.dogViewModel.flatMap(DogView.init(viewModel:))
                .frame(height: 216, alignment: .center)
            Button("What da dog doin?", action: viewModel.newPupperTapped)
        }
    }
}

struct RandomDogView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let viewModel = RandomDogViewModel(data: data)
        return RandomDogView(viewModel: viewModel)
    }
}
