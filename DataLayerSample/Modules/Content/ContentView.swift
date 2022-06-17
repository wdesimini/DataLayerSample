//
//  ContentView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 12/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        VStack(
            alignment: .center,
            spacing: 12
        ) {
            Text(
                viewModel.contentText
            )
            .frame(height: 54)
            Button(
                "update",
                action: viewModel.updateContent
            )
            .frame(height: 54)
            Button(
                "show child",
                action: viewModel.showChildContent
            )
            .frame(height: 54)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let mock = data.contentData.mockObject
        let viewModel = ContentViewModel(contentId: mock.id, model: data)
        return ContentView(viewModel: viewModel)
    }
}
