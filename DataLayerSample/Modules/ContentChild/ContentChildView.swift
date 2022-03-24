//
//  ContentChildView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import SwiftUI

struct ContentChildView<
    ViewModelType: ContentChildViewModelInput
> : View {
    @ObservedObject var viewModel: ViewModelType
    
    var body: some View {
        VStack {
            Text(
                viewModel.contentChildText
            )
            Button(
                "exit",
                action: viewModel.dismissPublisher
            )
        }
    }
}

struct ContentChildView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let mock = data.contentChildData.mockObject
        let viewModel = ContentChildViewModel(
            contentChildId: mock.id, data: data
        )
        return ContentChildView(viewModel: viewModel)
    }
}
