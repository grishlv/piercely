//
//  PhotoHandlerScreenBuilder.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 13.12.25.
//

import SwiftUI

final class PhotoHandlerScreenBuilder {
    // MARK: Private properties
    private let screenFactory: PhotoHandlerScreenFactory
    
    // MARK: Life cycle
    init(screenFactory: PhotoHandlerScreenFactory) {
        self.screenFactory = screenFactory
    }
}

// MARK: - Public methods
extension PhotoHandlerScreenBuilder {
    func buildView() -> some View {
        let viewModel = screenFactory.makePhotoPreviewViewModel()

        let view = PhotoPreviewScreen(viewModel: viewModel)
        
        return view
    }
}

