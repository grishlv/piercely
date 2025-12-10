//
//  MainScreenViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 30.11.25.
//

import Combine
import SwiftUI
import PhotosUI

@MainActor
protocol MainScreenViewModel: ObservableObject {
    var selectedPhotoItem: PhotosPickerItem? { get set }
    var isPhotoPickerPresented: Bool { get set }
    var isCameraPresented: Bool { get set }
    var tryOnCardViewModel: TryOnCardViewModelImpl { get }
    
    func handleImageSelected(_ image: UIImage)
}

final class MainScreenViewModelImpl: MainScreenViewModel {
    @Published var selectedPhotoItem: PhotosPickerItem?
    @Published var isPhotoPickerPresented = false
    @Published var isCameraPresented = false
    @Published var selectedImage: UIImage?
    
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
    
    func handleImageSelected(_ image: UIImage) {
        selectedImage = image
        print("✅ Image selected: \(image.size)")
    }
}
