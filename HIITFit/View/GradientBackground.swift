//
//  GraidentBackground.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/26.
//

import SwiftUI

struct GradientBackground: View {
    var gradient: Gradient {
        Gradient(colors: [Color("gradient-top"),
                         Color("gradient-bottom"),
                         Color("background")])
    }
    var body: some View {
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    GradientBackground()
}
