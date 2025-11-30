//
//  MainScreenView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 04.11.25.
//

import SwiftUI

struct MainAppView: View {
    @StateObject private var viewModel = MainScreenViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                TryOnCardView(viewModel: viewModel.tryOnCardViewModel)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(ColorToken.primaryBackground.ignoresSafeArea())
    }
}
