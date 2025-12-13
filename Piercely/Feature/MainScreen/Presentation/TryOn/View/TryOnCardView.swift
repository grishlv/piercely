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
        ZStack(alignment: .leading) {
            Image("tryOnBackground")
                .resizable()
                .aspectRatio(360/230, contentMode: .fit)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(tryOnCardEntity.title)
                    .font(FontToken.titleMainScreen)
                    .foregroundColor(ColorToken.whiteColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 20)
                VStack(spacing: 12) {
                    Button { 
                        viewModel.uploadPhoto()
                    } label: {
                        HStack(spacing: 6) {
                            Image(tryOnCardEntity.uploadPhotoImage)
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Text(tryOnCardEntity.uploadPhotoTitle.uppercased())
                                .font(FontToken.buttonMainScreenTitle)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(width: 140, height: 40)
                    .background(ColorToken.blueButtonColor) // make a gradient color
                    .foregroundColor(ColorToken.whiteColor)
                    .cornerRadius(50)
                    
                    Button {
                        viewModel.takePhoto()
                    } label: {
                        HStack(spacing: 6) {
                            Image(tryOnCardEntity.takePhotoImage)
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Text(tryOnCardEntity.takePhotoTitle.uppercased())
                                .font(FontToken.buttonMainScreenTitle)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(width: 140, height: 40)
                    .background(ColorToken.whiteColor)
                    .foregroundColor(ColorToken.secondaryGreyColor)
                    .cornerRadius(50)
                }
            }
            .padding(.leading, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
}
