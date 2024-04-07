//
//  Model3DRotatingView.swift
//  Presenting3DContent
//
//  Created by Jacob Van Order on 4/7/24.
//


import SwiftUI
import RealityKit

struct Model3DRotatingView<PlaceholderContent: View>: View {

    let duration: TimeInterval
    let speed: Double
    let assetName: String
    let axis: RotationAxis3D
    @ViewBuilder let placeholder: PlaceholderContent
    @State private var isAnimating: Bool = false

    private let animation: Animation

    var body: some View {
        Model3D(named: assetName) { model in
            model
                .resizable()
                .aspectRatio(contentMode: .fit)
                .animation(animation) { content in
                    content
                        .rotation3DEffect(.degrees(isAnimating ? -360 : 0),
                                          axis: axis)
                }
                .onAppear {
                    isAnimating = true
                }
        } placeholder: {
            placeholder
        }
    }

    init(duration: TimeInterval = 10.0,
         speed: Double = 1.3,
         named assetName: String,
         axis: RotationAxis3D = .y,
         placeholder: () -> PlaceholderContent) {
        self.duration = duration
        self.speed = speed
        self.assetName = assetName
        self.axis = axis
        self.placeholder = placeholder()
        self.animation = Animation
            .linear(duration: duration)
            .speed(speed)
            .repeatForever(autoreverses: false)
    }
}

#Preview {
    Model3DRotatingView(named: "mega_man",
                        placeholder: { ProgressView() })
    .frame(width: 200)
    .padding(100)
    .glassBackgroundEffect()
}

