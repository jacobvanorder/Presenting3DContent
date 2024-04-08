//
//  Model3DDragGestureView.swift
//  Presenting3DContent
//
//  Created by Jacob Van Order on 4/7/24.
//

import SwiftUI
import RealityKit

struct Model3DDragGestureView<PlaceholderContent: View>: View {
    let named: String
    @ViewBuilder let placeholder: PlaceholderContent
    // Needed otherwise the model will snap back to identity transform when drag gesture starts.
    @State private var startSpinValue: Double?
    @State private var spinValue: Double = 0.0
    private let multiplier: Double = 5.0

    var body: some View {
        Model3D(named: named) { model in
            model
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotation3DEffect(.radians(spinValue), axis: .y)
                .gesture(DragGesture()
                    .targetedToAnyEntity()
                    .onChanged { value in
                        if startSpinValue == nil {
                            startSpinValue = spinValue
                        }
                        guard let startSpinValue else { return }
                        let startLocationX = value.convert(value.startLocation3D, from: .local, to: .scene).x
                        let currentLocationX = value.convert(value.location3D, from: .local, to: .scene).x

                        let delta = currentLocationX - startLocationX
                        spinValue = (Double(delta) * multiplier) + startSpinValue
                    }
                    .onEnded { _ in
                        startSpinValue = nil
                    })
        } placeholder: {
            placeholder
        }
    }
}

#Preview {
    Model3DDragGestureView(named: "mega_man") {
        ProgressView()
    }
}

/// An alternate way to rotate using the transform rotation.
struct Model3DDragGestureAltView<PlaceholderContent: View>: View {
    let named: String
    @ViewBuilder let placeholder: PlaceholderContent
    // Needed otherwise the model will snap back to identity transform when drag gesture starts.
    @State private var startSpinValue: Float?
    private let multiplier: Float = 5.0

    var body: some View {
        Model3D(named: named) { model in
            model
                .resizable()
                .aspectRatio(contentMode: .fit)
                .gesture(DragGesture()
                    .targetedToAnyEntity()
                    .onChanged { value in
                        if startSpinValue == nil {
                            startSpinValue = value.entity.transform.rotation.angle
                        }
                        guard let startSpinValue else { return }
                        let startLocationX = value.convert(value.startLocation3D, from: .local, to: .scene).x
                        let currentLocationX = value.convert(value.location3D, from: .local, to: .scene).x

                        let delta = (currentLocationX - startLocationX) * multiplier
                        value.entity.transform.rotation = simd_quatf(angle: delta + startSpinValue,
                                                                     axis: SIMD3(x: 0, y: 1, z: 0))
                    }
                    .onEnded { _ in
                        startSpinValue = nil
                    })
        } placeholder: {
            placeholder
        }
    }
}
