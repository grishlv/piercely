//
//  EditorToolBarView.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 17.12.25.
//

import SwiftUI

struct EditorToolbar: View {
    @Binding var selectedTool: EditorTool?
    let onToolSelected: (EditorTool) -> Void
    
    private let tools: [EditorTool] = [
        .contrast,
        .saturation,
        .blur,
        .sharpen
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(tools) { tool in
                    EditorToolButton(
                        tool: tool,
                        isSelected: selectedTool == tool,
                        action: {
                            selectedTool = tool
                            onToolSelected(tool)
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

enum EditorTool: String, Identifiable, CaseIterable {
    case contrast
    case saturation
    case blur
    case sharpen
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .contrast: return "Contrast"
        case .saturation: return "Saturation"
        case .blur: return "Blur"
        case .sharpen: return "Sharpen"
        }
    }
    
    var icon: String {
        switch self {
        case .contrast: return "circle.lefthalf.filled"
        case .saturation: return "paintpalette"
        case .blur: return "sparkles"
        case .sharpen: return "wand.and.stars"
        }
    }
}
