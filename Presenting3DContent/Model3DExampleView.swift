//
//  Model3DExampleView.swift
//  Presenting3DContent
//
//  Created by Jacob Van Order on 4/5/24.
//

import Foundation
import SwiftUI
import RealityKit

struct Model3DExampleView: View {
    let named: String
    var body: some View {
        Model3D(named: named) { content in
            content
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview(windowStyle: .plain) {
    VStack {
        Model3DExampleView(named: "mega_man")
            .frame(width: 200, height: 200)
        Text("Mega Man")
            .font(.extraLargeTitle)
    }
}
