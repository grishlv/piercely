//
//  PhotoPreviewScreen.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 13.12.25.
//

import SwiftUI

struct PhotoPreviewScreen<ViewModel: PhotoPreviewViewModel>: View {
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZoomableImage(image: viewModel.image, minScale: 1, maxScale: 6)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.9)
                    .background(Color.black)

                EditorToolbar(
                    selectedTool: $viewModel.selectedTool,
                    onToolSelected: { tool in
                        viewModel.applyTool(tool)
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.1)
                .background(ColorToken.primaryBackground)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Preview")
                    .font(.headline)
            }
        }
    }
}
