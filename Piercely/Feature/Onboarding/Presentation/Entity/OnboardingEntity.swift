//
//  OnboardingEntity.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 05.10.25.
//

import Foundation

struct OnboardingEntity: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
    let buttonTitle: String
}
