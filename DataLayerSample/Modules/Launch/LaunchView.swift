//
//  LaunchView.swift
//  DataLayerSample
//
//  Created by Wilson Desimini on 3/26/22.
//

import SwiftUI

struct LaunchView<ViewModelType: LaunchViewModelInput>: View {
    @ObservedObject var viewModel: ViewModelType
    
    var body: some View {
        Text(
            viewModel.launchViewMessage
        )
        .onAppear(
            perform: viewModel.launchViewDidAppear
        )
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let model = data.contentData
        let viewModel = LaunchViewModel(model: model)
        return LaunchView(viewModel: viewModel)
    }
}
