





//
//  ContentView.swift
//  Presenting3DContent
//
//  Created by Jacob Van Order on 4/1/24.
//

import SwiftUI
import RealityKit
import Combine

struct ContentView: View {
    
    @State var depth: Double = 0.0
    @State var eventSubscriptions: [EventSubscription] = []

    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Model3DExampleView(named: "mega_man")
                    .frame(width: 200, height: 200)
                Text("Model 3D")
                    .font(.largeTitle)
            }
            VStack {
                Model3DRotatingView(named: "mega_man") {
                    ProgressView()
                }
                    .frame(width: 200, height: 200)
                Text("Model 3D Rotation")
                    .font(.largeTitle)
            }
            VStack {
                Model3DDragGestureView(named: "mega_man") {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                Text("Model 3D Drag Rotation")
                    .font(.largeTitle)
            }
            VStack {
                Model3DRotateGestureView(named: "mega_man") {
                    ProgressView()
                }
                    .frame(width: 200, height: 200)
                Text("Model 3D Rotation Gesture")
                    .font(.largeTitle)
            }
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
}

#Preview(windowStyle: .plain) {
    ContentView()
}
