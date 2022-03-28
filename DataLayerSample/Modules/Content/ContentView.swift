//
//  ContentView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import SwiftUI

struct ContentView<ViewModelType>: View
where ViewModelType: ContentViewModelInput {
    @ObservedObject var viewModel: ViewModelType
    
    var body: some View {
        VStack(spacing: 12) {
            Text(
                viewModel.contentText
            )
            .frame(height: 54)
            Button(
                "update",
                action: viewModel.didTapUpdate
            )
            .frame(height: 54)
            Button(
                "show child",
                action: viewModel.didTapShowChild
            )
            .frame(height: 54)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let mock = data.contentData.mockObject
        let viewModel = ContentViewModel(
            contentId: mock.id, service: data.contentData
        )
        return ContentView(viewModel: viewModel)
    }
}
