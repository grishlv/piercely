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
                .frame(height: 120)
            
            Text(page.title)
                .font(.system(size: 48, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
            
            if !page.subtitle.isEmpty {
                Text(page.subtitle)
                    .font(.system(size: 24))
                    .foregroundColor(
                        Color(
                            red: 162 / 255.0,
                            green: 162 / 255.0,
                            blue: 162 / 255.0
                        )
                    )
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.top, 16)
            }
            
            Spacer()
            
            Image(page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 400)
                .padding(.horizontal, 32)
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.completeOnboarding()
                }
            } label: {
                Text(page.buttonTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.blue)
                    .cornerRadius(28)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
    }
}
