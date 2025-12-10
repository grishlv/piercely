//
//  AppCoordinatorView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 07.12.25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        Group {
            if coordinator.showOnboarding {
                makeOnboardingScreen().buildView()
            } else {
                NavigationStack(path: $coordinator.navigationPath) {
                    makeMainScreen().buildView()
//                        .navigationDestination(for: NavigationDestination.self) { destination in
//                            destinationView(for: destination)
//                        }
                }
            }
        }
    }
}

private extension AppCoordinatorView {
//    @ViewBuilder
//    func destinationView(for destination: NavigationDestination) -> some View? {
//    }
}

// MARK: - Onboarding Screen
private extension AppCoordinatorView {
    func makeOnboardingScreen() -> OnboardingScreenBuilder {
        OnboardingScreenBuilder(screenFactory: .init(coordinator: coordinator))
    }
}

// MARK: - Main Screen
private extension AppCoordinatorView {
    func makeMainScreen() -> MainScreenBuilder {
        MainScreenBuilder(screenFactory: .init(coordinator: coordinator))
    }
}
