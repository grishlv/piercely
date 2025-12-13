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
        .sheet(isPresented: $viewModel.isCameraPresented) {
            ImagePicker(
                sourceType: .camera,
                selectedImage: { image in
                    viewModel.handleImageSelected(image)
                }
            )
        }
        .onChange(of: viewModel.selectedPhotoItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    viewModel.handleImageSelected(image)
                }
            }
        }
    }
}
