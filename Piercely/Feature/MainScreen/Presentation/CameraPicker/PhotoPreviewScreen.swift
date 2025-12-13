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
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.9)
                    .background(Color.black)
                
                VStack {
                    // TODO: Horizontal scroll bar with editing tools
                    Text("Editor Toolbar Placeholder")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
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
