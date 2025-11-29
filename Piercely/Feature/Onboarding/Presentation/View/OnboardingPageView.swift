//
//  OnboardingPageView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 04.11.25.
//

import Foundation
import SwiftUI

struct OnboardingPageView<ViewModel: OnboardingScreenViewModel>: View {
    let page: OnboardingEntity
    
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 70)
            
            if let accent = page.titleAccent {
                Text("\(Text(page.title).font(FontToken.headline))\(Text(accent).font(FontToken.headlineAccent))")
                    .foregroundColor(ColorToken.whiteColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            } else {
                Text(page.title)
                    .font(FontToken.headline)
                    .foregroundColor(ColorToken.whiteColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            }
            
            if let lineAccent = page.onboardingAccentLine {
                Image(lineAccent)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 16)
                    .padding(.trailing, 90)
            }
            
            if !page.subtitle.isEmpty {
                Text(page.subtitle)
                    .font(FontToken.subtitle)
                    .foregroundColor(ColorToken.subtitleColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
            }
                        
            Image(page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 400)
                .padding(.horizontal, 16)
                        
            Button {
                Task {
                    await viewModel.completeOnboarding()
                }
            } label: {
                Text(page.buttonTitle)
                    .font(FontToken.buttonOnboardingTitle)
                    .foregroundColor(ColorToken.whiteColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 75)
                    .background(ColorToken.blueButtonColor)
                    .cornerRadius(50)
            }
            .padding(.horizontal, 16)
        }
    }
}
