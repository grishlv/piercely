//
//  MainScreenBuilder.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 10.12.25.
//

import SwiftUI

final class MainScreenBuilder {
    // MARK: Private properties
    private let screenFactory: MainScreenFactory
    
    // MARK: Life cycle
    init(screenFactory: MainScreenFactory) {
        self.screenFactory = screenFactory
    }
}

// MARK: - Public methods
extension MainScreenBuilder {
    func buildView() -> some View {
        let viewModel = screenFactory.makeMakeScreenViewModel()

        let view = MainScreenView(viewModel: viewModel)
        
        return view
    }
}
