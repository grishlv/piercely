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
    var selectedTool: EditorTool? { get set }
    
    func applyTool(_ tool: EditorTool)
}

final class PhotoPreviewViewModelImpl: PhotoPreviewViewModel {
    @Published var image: UIImage
    @Published var selectedTool: EditorTool?
    
    init(image: UIImage) {
        self.image = image
    }
    
    func applyTool(_ tool: EditorTool) {
        switch tool {
        case .contrast:
            applyContrast(value: 1.2)
        case .saturation:
            applySaturation(value: 1.5)
        case .blur:
            applyBlur(radius: 5)
        case .sharpen:
            applySharpen()
        }
    }
    
    private func applyContrast(value: CGFloat) {
        // TODO: Implement contrast adjustment
    }
    
    private func applySaturation(value: CGFloat) {
        // TODO: Implement saturation adjustment
    }
    
    private func applyBlur(radius: CGFloat) {
        // TODO: Implement blur effect
    }
    
    private func applySharpen() {
        // TODO: Implement sharpen effect
    }
}
