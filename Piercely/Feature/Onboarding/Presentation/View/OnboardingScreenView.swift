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
            Color.black.ignoresSafeArea()
            
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
                // Индикатор страниц
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.pages.count, id: \.self) { index in
                        Capsule()
                            .fill(index == viewModel.currentPage ? Color.white : Color.gray)
                            .frame(width: index == viewModel.currentPage ? 40 : 8, height: 8)
                            .animation(.easeInOut, value: viewModel.currentPage)
                    }
                }
                .padding(.top, 50)
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $viewModel.shouldShowMainApp) {
            MainAppView()
        }
    }
}
