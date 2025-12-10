//
//  MainScreenFactory.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 10.12.25.
//

import Foundation

final class MainScreenFactory {
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainScreenFactory {
    func makeMakeScreenViewModel() -> MainScreenViewModelImpl {
        MainScreenViewModelImpl(coordinator: coordinator)
    }
}

