//
//  Model3DRotateGestureView.swift
//  Presenting3DContent
//
//  Created by Jacob Van Order on 4/7/24.
//

import SwiftUI
import RealityKit

struct Model3DRotateGestureView<PlaceholderContent: View>: View {
    let named: String
    @ViewBuilder let placeholder: PlaceholderContent
    @State private var entityTransform: Transform?
    var body: some View {
        Model3D(named: named) { content in
            content
                .resizable()
                .scaledToFit()
                .gesture(RotateGesture3D(constrainedToAxis: .y)
                    .targetedToAnyEntity()
                    .onChanged({ rotateGesture3D in
                        if entityTransform == nil {
                            entityTransform = rotateGesture3D.entity.transform
                        }

                        guard let entityTransform else { return }

                        let rotationTransform = Transform(AffineTransform3D(rotation: rotateGesture3D.rotation))
                        rotateGesture3D.entity.transform.rotation = entityTransform.rotation * rotationTransform.rotation
                    })
                        .onEnded({ _ in
                            entityTransform = nil
                        }))
        } placeholder: {
            placeholder
        }
    }
}

#Preview {
    Model3DRotateGestureView(named: "mega_man") {
        ProgressView()
    }
}
