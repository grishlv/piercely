//
//  OnboardingView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 05.10.25.
//

import SwiftUI

struct OnboardingScreenView<ViewModel: OnboardingScreenViewModel>: View {
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color(ColorToken.primaryBackground).ignoresSafeArea()

            TabView(selection: $viewModel.currentPage) {
                ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
                    OnboardingPageView(
                        page: page,
                        viewModel: viewModel
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.pages.count, id: \.self) { index in
                        Capsule()
                            .fill(index == viewModel.currentPage ? ColorToken.whiteColor : ColorToken.secondaryGreyColor)
                            .frame(width: index == viewModel.currentPage ? 110 : 100, height: 3)
                            .animation(.easeInOut, value: viewModel.currentPage)
                    }
                }
                .padding(.top, 50)
                
                Spacer()
            }
        }
    }
}
