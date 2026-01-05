//
//  ZoomableImage.swift
//  Piercely
//
//  Created by Grigorii Shiliaev on 26.12.25.
//

import SwiftUI

struct ZoomableImage: View {
    let image: UIImage
    var minScale: CGFloat = 1
    var maxScale: CGFloat = 5

    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    // pinch session state
    @State private var pinchStartScale: CGFloat = 1
    @State private var pinchStartOffset: CGSize = .zero
    @State private var pinchStartLocation: CGPoint = .zero
    @State private var isPinching: Bool = false

    var body: some View {
        GeometryReader { geo in
            let containerSize = geo.size

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale)
                .offset(offset)
                .frame(width: containerSize.width, height: containerSize.height)
                .contentShape(Rectangle())
                .gesture(doubleTapToReset())
                .simultaneousGesture(pinchGesture(containerSize: containerSize))
                .simultaneousGesture(panGesture(containerSize: containerSize))
        }
    }
}

private extension ZoomableImage {
    func doubleTapToReset() -> some Gesture {
        TapGesture(count: 2).onEnded {
            withAnimation(.easeOut(duration: 0.18)) {
                scale = 1
                lastScale = 1
                offset = .zero
                lastOffset = .zero
            }
        }
    }
    
    func pinchGesture(containerSize: CGSize) -> some Gesture {
        MagnifyGesture()
            .onChanged { value in
                if !isPinching {
                    isPinching = true
                    pinchStartScale = lastScale
                    pinchStartOffset = lastOffset
                    pinchStartLocation = value.startLocation
                }
                
                let targetScale = clamp(
                    pinchStartScale * value.magnification,
                    minScale,
                    maxScale
                )
                
                guard targetScale > minScale else {
                    scale = minScale
                    offset = .zero
                    return
                }
                
                let k = targetScale / max(pinchStartScale, 0.0001)
                
                let center = CGPoint(
                    x: containerSize.width / 2,
                    y: containerSize.height / 2
                )
                let anchor = CGPoint(
                    x: pinchStartLocation.x - center.x,
                    y: pinchStartLocation.y - center.y
                )
                
                // o1 = k*o0 + (1-k)*(p-c)
                let proposed = CGSize(
                    width: k * pinchStartOffset.width + (1 - k) * anchor.x,
                    height: k * pinchStartOffset.height + (1 - k) * anchor.y
                )
                
                scale = targetScale
                
                offset = clampedOffset(
                    proposed,
                    containerSize: containerSize,
                    imageSize: image.size,
                    scale: scale
                )
            }
            .onEnded { _ in
                isPinching = false
                lastScale = scale
                lastOffset = offset
            }
    }

    func panGesture(containerSize: CGSize) -> some Gesture {
        DragGesture()
            .onChanged { value in
                guard scale > 1.001 else { return }
                let proposed = CGSize(
                    width: lastOffset.width + value.translation.width,
                    height: lastOffset.height + value.translation.height
                )
                offset = clampedOffset(
                    proposed,
                    containerSize: containerSize,
                    imageSize: image.size,
                    scale: scale
                )
            }
            .onEnded { _ in
                lastOffset = offset
            }
    }

    func clampedOffset(_ proposed: CGSize, containerSize: CGSize, imageSize: CGSize, scale: CGFloat) -> CGSize {
        let fitted = aspectFitSize(imageSize: imageSize, in: containerSize)

        let contentW = fitted.width * scale
        let contentH = fitted.height * scale

        let extraW = max(0, (contentW - containerSize.width) / 2)
        let extraH = max(0, (contentH - containerSize.height) / 2)

        return CGSize(
            width: clamp(proposed.width, -extraW, extraW),
            height: clamp(proposed.height, -extraH, extraH)
        )
    }

    func aspectFitSize(imageSize: CGSize, in container: CGSize) -> CGSize {
        guard
            imageSize.width > 0,
            imageSize.height > 0
        else {
            return .zero
        }
        
        let s = min(
            container.width / imageSize.width,
            container.height / imageSize.height
        )
        return CGSize(
            width: imageSize.width * s,
            height: imageSize.height * s
        )
    }

    func clamp<T: Comparable>(_ x: T, _ a: T, _ b: T) -> T {
        min(max(x, a), b)
    }
}
