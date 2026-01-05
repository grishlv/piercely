//
//  EditorToolButton.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 17.12.25.
//

import SwiftUI

struct EditorToolButton: View {
    let tool: EditorTool
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tool.icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .blue : .primary)
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                )
            
            Text(tool.title)
                .font(.caption2)
                .foregroundColor(isSelected ? .blue : .secondary)
        }
        .onTapGesture {
            action()
        }
    }
}
