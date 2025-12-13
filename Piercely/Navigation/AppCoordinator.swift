//
//  AppCoordinator.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 07.12.25.
//

import SwiftUI
import Combine

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var showOnboarding: Bool
    @Published var navigationPath = NavigationPath()
    @Published var photoPreviewImage: UIImage?

    init() {
        self.showOnboarding = !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
}

extension AppCoordinator {
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        showOnboarding = false
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    func navigateToPhotoPreview(image: UIImage) {
        photoPreviewImage = image
        navigationPath.append(NavigationDestination.photoPreview)
    }
}

// MARK: - Navigation Destination
enum NavigationDestination: Hashable {
    case photoPreview
}

