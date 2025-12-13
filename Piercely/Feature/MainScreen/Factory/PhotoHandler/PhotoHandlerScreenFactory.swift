//
//  PhotoHandlerScreenFactory.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 13.12.25.
//

import SwiftUI

final class PhotoHandlerScreenFactory {
    private let coordinator: AppCoordinator
    private let image: UIImage
    
    init(
        coordinator: AppCoordinator,
        image: UIImage,
    ) {
        self.coordinator = coordinator
        self.image = image
    }
}

extension PhotoHandlerScreenFactory {
    func makePhotoPreviewViewModel() -> PhotoPreviewViewModelImpl {
        PhotoPreviewViewModelImpl(
            coordinator: coordinator,
            image: image,
        )
    }
}

