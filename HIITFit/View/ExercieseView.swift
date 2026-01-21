//
//  ExercieseView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI

struct ExercieseView: View {
    let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
    
    let exerciseNames = ["Squat", "Stup Up", "Burpee", "Sun Salute"]
    
    let index: Int
    
    var body: some View {
        Text(exerciseNames[index])
    }
}

#Preview {
    ExercieseView(index: 0)
}
