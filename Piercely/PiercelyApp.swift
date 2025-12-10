//
//  PiercelyApp.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 05.10.25.
//

import SwiftUI

@main
struct PiercelyApp: App {
    @StateObject
    private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: appCoordinator)
        }
    }
}
