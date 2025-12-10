//
//  OnboardingViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 15.10.25.
//

import SwiftUI
import Combine

@MainActor
protocol OnboardingScreenViewModel: ObservableObject {
    var currentPage: Int { get set }
    var pages: [OnboardingEntity] { get set }
    
    func completeOnboarding() async
    func nextPage()
    func skipToEnd()
}

final class OnboardingScreenViewModelImpl {
    @Published
    var currentPage = 0
    
    private weak var coordinator: AppCoordinator?
    
    var pages: [OnboardingEntity] = [
        OnboardingEntity(
            title: "Try on\npiercings",
            titleAccent: "\nin 30 seconds",
            subtitle: "",
            imageName: "firstOnboardingImage",
            buttonTitle: "Get Started",
            onboardingAccentLine: "onboardingAccentLine"
        ),
        OnboardingEntity(
            title: "Realistic \nmetals \nand sizes",
            titleAccent: nil,
            subtitle: "Curated 3D models, accurate \ndiameters and gauges. Fine-tune \nin a tap.",
            imageName: "secondOnboardingImage",
            buttonTitle: "Continue",
            onboardingAccentLine: nil,
        ),
        OnboardingEntity(
            title: "No sign-up. \nNo ads.",
            titleAccent: nil,
            subtitle: "Pick Ear or Nose, add a photo. \nSave 1080p for free.",
            imageName: "thirdOnboardingImage",
            buttonTitle: "Let's Go",
            onboardingAccentLine: nil,
        ),
    ]
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}

extension OnboardingScreenViewModelImpl: OnboardingScreenViewModel {
    func completeOnboarding() async {
        coordinator?.completeOnboarding()
    }
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            currentPage += 1
        }
    }

    func skipToEnd() {
        currentPage = pages.count - 1
    }
}
