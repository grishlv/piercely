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
        ZStack {
            ScrollView {
                VStack() {
                    TryOnCardView(viewModel: viewModel.tryOnCardViewModel)
                }
                .padding(.top, 20)
            }
            .background(ColorToken.primaryBackground.ignoresSafeArea())
            
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
        // MARK: - Photo Picker
        .photosPicker(
            isPresented: $viewModel.isPhotoPickerPresented,
            selection: $viewModel.selectedPhotoItem,
            matching: .images,
            photoLibrary: .shared()
        )
        .onChange(of: viewModel.selectedPhotoItem) { _, newValue in
            Task {
                await viewModel.handlePhotoItemSelected(newValue)
            }
        }
        // MARK: - Camera Sheet
        .sheet(isPresented: $viewModel.isCameraPresented) {
            CameraPickerView(
                onImageCaptured: { image in
                    viewModel.isLoading = false
                    viewModel.isCameraPresented = false
                    viewModel.handleImageSelected(image)
                },
                onCancel: {
                    viewModel.isLoading = false
                    viewModel.isCameraPresented = false
                }
            )
            .ignoresSafeArea()
        }
        .alert("Camera Access Required", isPresented: $viewModel.isCameraPermissionAlertPresented) {
            Button("Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please enable camera access in Settings to take photos.")
        }
    }
}
