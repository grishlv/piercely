//
//  MainScreenViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 30.11.25.
//

import Combine
import SwiftUI
import PhotosUI
import AVFoundation

@MainActor
protocol MainScreenViewModel: ObservableObject {
    var selectedPhotoItem: PhotosPickerItem? { get set }
    var isPhotoPickerPresented: Bool { get set }
    var isCameraPresented: Bool { get set }
    var isLoading: Bool { get set }
    var isCameraPermissionAlertPresented: Bool { get set }
    var tryOnCardViewModel: TryOnCardViewModelImpl { get }
    
    func handlePhotoItemSelected(_ item: PhotosPickerItem?) async
    func handleImageSelected(_ image: UIImage)
}

final class MainScreenViewModelImpl: MainScreenViewModel {
    @Published var selectedPhotoItem: PhotosPickerItem?
    @Published var selectedImage: UIImage?
    @Published var isPhotoPickerPresented = false
    @Published var isCameraPresented = false
    @Published var isCameraPermissionAlertPresented = false
    @Published var isLoading = false
    
    private weak var coordinator: AppCoordinator?
        
    lazy var tryOnCardViewModel: TryOnCardViewModelImpl = {
        TryOnCardViewModelImpl(
            onUploadPhoto: { [weak self] in
                guard let self else { return }
                self.isPhotoPickerPresented = true
            },
            onTakePhoto: { [weak self] in
                guard let self else { return }
                self.isCameraPresented = true
            }
        )
    }()
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainScreenViewModelImpl {
    func handlePhotoItemSelected(_ item: PhotosPickerItem?) async {
        guard let item else { return }
        
        isLoading = true
        
        // Load the selected photo in the background
        Task.detached(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            do {
                // Fetch image data
                if let data = try await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    // Switch back to the main thread to update UI
                    await MainActor.run {
                        self.isLoading = false
                        self.selectedPhotoItem = nil
                        self.coordinator?.navigateToPhotoPreview(image: image)
                    }
                } else {
                    // No data or failed to create image
                    await MainActor.run {
                        self.isLoading = false
                        self.selectedPhotoItem = nil
                    }
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.selectedPhotoItem = nil
                }
            }
        }
    }
    
    func handleImageSelected(_ image: UIImage) {
        self.coordinator?.navigateToPhotoPreview(image: image)
    }
}

private extension MainScreenViewModelImpl {
    func requestOpenCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isLoading = true
            
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 50_000_000)
                self.isCameraPresented = true
            }
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                Task { @MainActor in
                    guard let self else { return }
                    if granted {
                        self.isLoading = true
                        try? await Task.sleep(nanoseconds: 50_000_000)
                        self.isCameraPresented = true
                    } else {
                        self.isCameraPermissionAlertPresented = true
                    }
                }
            }

        case .denied, .restricted:
            isCameraPermissionAlertPresented = true

        @unknown default:
            isCameraPermissionAlertPresented = true
        }
    }
}
