//
//  TryOnCardViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 29.11.25.
//

import Combine

@MainActor
protocol TryOnCardViewModel: ObservableObject {
    var tryOnCard: TryOnEntity { get set }
    func uploadPhoto()
    func takePhoto()
}

final class TryOnCardViewModelImpl: ObservableObject {    
    private let onUploadPhoto: () -> Void
    private let onTakePhoto: () -> Void
    
    var tryOnCard: TryOnEntity = .init(
        title: "See exactly how your \ndream piercing looks \non you",
        uploadPhotoTitle: "Upload Photo",
        uploadPhotoImage: "magicStars",
        takePhotoTitle: "Take Photo",
        takePhotoImage: "capture",
        image: "peopleCollage"
    )
    
    init(
        onUploadPhoto: @escaping () -> Void,
        onTakePhoto: @escaping () -> Void
    ) {
        self.onUploadPhoto = onUploadPhoto
        self.onTakePhoto = onTakePhoto
    }
}

extension TryOnCardViewModelImpl: TryOnCardViewModel {
    func uploadPhoto() {
        onUploadPhoto()
    }
    
    func takePhoto() {
        onTakePhoto()
    }
}
