//
//  MainScreenView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 04.11.25.
//

import SwiftUI
import PhotosUI

enum PhotoSource {
    case library
    case camera
}

struct MainScreenView<ViewModel: MainScreenViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack() {
                TryOnCardView(viewModel: viewModel.tryOnCardViewModel)
            }
            .padding(.top, 20)
        }
        .background(ColorToken.primaryBackground.ignoresSafeArea())
        .photosPicker(
            isPresented: $viewModel.isPhotoPickerPresented,
            selection: $viewModel.selectedPhotoItem,
            matching: .images
        )
        .onChange(of: viewModel.selectedPhotoItem) { newItem, _ in
            Task {
                await viewModel.handlePhotoItemSelected(newItem)
            }
        }
        .sheet(isPresented: $viewModel.isCameraPresented) {
            CameraPickerView { image in
                viewModel.handleImageSelected(image)
            }
        }
    }
}
