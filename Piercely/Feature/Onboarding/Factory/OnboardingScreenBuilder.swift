//
//  OnboardingScreenBuilder.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 04.11.25.
//

import SwiftUI

final class OnboardingScreenBuilder {
    // MARK: Private properties
    private let screenFactory: OnboardingScreenFactory
    
    // MARK: Life cycle
    init(screenFactory: OnboardingScreenFactory) {
        self.screenFactory = screenFactory
    }
}

// MARK: - Public methods
extension OnboardingScreenBuilder {
    func buildView() -> some View {
        let viewModel = screenFactory.makeOnboardingScreenViewModel()

        let view = OnboardingScreenView(viewModel: viewModel)
        
        return view
    }
}
