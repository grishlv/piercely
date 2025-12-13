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
    func requestOpenCamera()
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
                self.requestOpenCamera()
            }
        )
    }()
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainScreenViewModelImpl {
    @MainActor
    func handlePhotoItemSelected(_ item: PhotosPickerItem?) async {
        guard let item else { return }
                   
        isLoading = true
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                
                self.selectedPhotoItem = nil
                
                await proceedToPreview(with: image)
            } else {
                print("❌ Failed to decode image from data")
                isLoading = false
                self.selectedPhotoItem = nil
            }
        } catch {
            print("❌ Failed to load image: \(error)")
            isLoading = false
            self.selectedPhotoItem = nil
        }
    }
    
    func handleImageSelected(_ image: UIImage) {
        Task { @MainActor in
            isLoading = true
            
            await proceedToPreview(with: image)
        }
    }
    
    @MainActor
    private func proceedToPreview(with image: UIImage) async {
        try? await Task.sleep(nanoseconds: 600_000_000)
        
        isLoading = false
        coordinator?.navigateToPhotoPreview(image: image)
    }
    
    func requestOpenCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isCameraPresented = true

        case .notDetermined:
            Task {
                let granted = await AVCaptureDevice.requestAccess(for: .video)
                await MainActor.run {
                    if granted {
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
