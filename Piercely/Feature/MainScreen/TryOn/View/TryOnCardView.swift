//
//  TryOnCardView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 29.11.25.
//

import SwiftUI
import Combine

struct TryOnCardView<ViewModel: TryOnCardViewModel>: View {
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        let tryOnCardEntity = viewModel.tryOnCard
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                Text(tryOnCardEntity.title)
                    .font(FontToken.subtitle)
                    .foregroundColor(ColorToken.whiteColor)
                    .multilineTextAlignment(.leading)
                VStack(spacing: 8) {
                    Button {
                        viewModel.uploadPhoto()
                    } label: {
                        Image(tryOnCardEntity.uploadPhotoImage)
                            .resizable()

                        Text(tryOnCardEntity.uploadPhotoTitle.uppercased())
                            .font(FontToken.buttonOnboardingTitle)
                            .frame(maxWidth: .infinity, minHeight: 48)
                    }
                    .background(ColorToken.blueButtonColor) // make a gradient color
                    .foregroundColor(ColorToken.whiteColor)
                    .cornerRadius(50)
                    
                    Button {
                        viewModel.takePhoto()
                    } label: {
                        Image(tryOnCardEntity.takePhotoImage)
                            .resizable()

                        Text(tryOnCardEntity.takePhotoTitle.uppercased())
                            .font(FontToken.buttonOnboardingTitle)
                            .frame(maxWidth: .infinity, minHeight: 48)
                    }
                    .background(ColorToken.whiteColor)
                    .foregroundColor(ColorToken.secondaryGreyColor)
                    .cornerRadius(50)
                }
            }
            Spacer(minLength: 0)
            
            Image(tryOnCardEntity.image)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 160)
                .clipped()
                .cornerRadius(24)
        }
        .padding(16)
        .background(ColorToken.secondaryGreyColor.ignoresSafeArea())
        .frame(width: 360, height: 230)
        .cornerRadius(25)
    }
}
