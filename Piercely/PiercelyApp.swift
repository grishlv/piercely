//
//  PiercelyApp.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 05.10.25.
//

import SwiftUI

@main
struct PiercelyApp: App {
    private let onboardingBuilder = OnboardingScreenBuilder()
    
    var body: some Scene {
        WindowGroup {
            onboardingBuilder.buildView()
        }
    }
}
