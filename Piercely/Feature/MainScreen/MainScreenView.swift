//
//  MainScreenView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 04.11.25.
//

import SwiftUI

struct MainAppView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            Text("Main App")
                .font(.largeTitle)
                .foregroundColor(ColorToken.primaryBackground)
        }
    }
}
