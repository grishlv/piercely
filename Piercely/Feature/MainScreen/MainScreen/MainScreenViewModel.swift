//
//  MainScreenViewModel.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 30.11.25.
//

import Combine

@MainActor
final class MainScreenViewModel: ObservableObject {
    lazy var tryOnCardViewModel = TryOnCardViewModelImpl(
        onUploadPhoto: {
            
        },
        onTakePhoto: {
            
        }
    )
}
