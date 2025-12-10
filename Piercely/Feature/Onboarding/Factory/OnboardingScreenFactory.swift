//
//  OnboardingScreenFactory.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 04.11.25.
//

import Foundation

final class OnboardingScreenFactory {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}

extension OnboardingScreenFactory {
    func makeOnboardingScreenViewModel() -> OnboardingScreenViewModelImpl {
        OnboardingScreenViewModelImpl(coordinator: coordinator)
    }
}
