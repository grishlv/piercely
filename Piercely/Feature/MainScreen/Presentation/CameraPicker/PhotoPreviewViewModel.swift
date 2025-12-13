//
//  PhotoPreviewViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 13.12.25.
//

import SwiftUI
import Combine

@MainActor
protocol PhotoPreviewViewModel: ObservableObject {
    var image: UIImage { get set }
}

final class PhotoPreviewViewModelImpl: PhotoPreviewViewModel {
    @Published var image: UIImage
    
    private weak var coordinator: AppCoordinator?
    
    init(
        coordinator: AppCoordinator,
        image: UIImage,
    ) {
        self.coordinator = coordinator
        self.image = image
    }
    
    // TODO: Методы для работы с editor toolbar
}
