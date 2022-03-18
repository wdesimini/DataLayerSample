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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let contents = data.contentData.objectsById.values
        let contentId = contents.first!.id
        let viewModel = ContentViewModel(contentId: contentId, data: data)
        return ContentView(viewModel: viewModel)
    }
}
