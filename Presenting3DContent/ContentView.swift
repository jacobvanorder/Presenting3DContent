





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
        HStack {
            VStack {
                Model3DExampleView(named: "mega_man")
                    .frame(width: 200, height: 200)
                Text("Model 3D")
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
