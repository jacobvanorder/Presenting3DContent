//
//  Presenting3DContentApp.swift
//  Presenting3DContent
//
//  Created by Jacob Van Order on 4/1/24.
//

import SwiftUI

@main
struct Presenting3DContentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
