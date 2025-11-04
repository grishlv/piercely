//
//  OnboardingViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 15.10.25.
//

import SwiftUI
import Combine

protocol OnboardingScreenViewModel: ObservableObject {
    var currentPage: Int { get set }
    var pages: [OnboardingEntity] { get set }
    var shouldShowMainApp: Bool { get set }
    func completeOnboarding () async
    func nextPage()
    func skipToEnd()
}

@MainActor
final class OnboardingScreenViewModelImpl {
    @Published
    var currentPage = 0
    
    @Published
    var shouldShowMainApp = false
    
    var pages: [OnboardingEntity] = [
        OnboardingEntity(
            title: "Try on\npiercings\nin 30 seconds",
            subtitle: "",
            imageName: "firstOnboardingImage",
            buttonTitle: "Get Started"
        ),
        OnboardingEntity(
            title: "Choose from\n1000+ styles",
            subtitle: "Find the perfect look for you",
            imageName: "secondOnboardingImage",
            buttonTitle: "Continue"
        ),
        OnboardingEntity(
            title: "Share with\nfriends",
            subtitle: "Get opinions before you commit",
            imageName: "thirdOnboardingImage",
            buttonTitle: "Let's Go"
        )
    ]
}

extension OnboardingScreenViewModelImpl: OnboardingScreenViewModel {
    func completeOnboarding() async {
        // Сохраняем, что онбординг пройден
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        shouldShowMainApp = true
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
