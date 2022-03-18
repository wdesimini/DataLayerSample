//
//  ContentChildView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/18/22.
//

import SwiftUI

struct ContentChildView: View {
    @ObservedObject var viewModel: ContentChildViewModel
    
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
        let mockId = data.contentChildData.objectsById.keys.first!
        let viewModel = ContentChildViewModel(contentChildId: mockId, data: data)
        return ContentChildView(viewModel: viewModel)
    }
}
