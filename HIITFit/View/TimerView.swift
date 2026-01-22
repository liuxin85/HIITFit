//
//  TimerView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/22.
//

import SwiftUI

struct CountDownView: View {
    let date: Date
    @Binding var timeRamaining: Int
    let size: Double
    
    var body: some View {
        Text("\(timeRamaining)")
            .font(.system(size: size, design: .rounded))
            .padding()
            .onChange(of: date) {
                timeRamaining -= 1
            }
    }
}

struct TimerView: View {
    @State private var timeRemaing: Int = 3
    @Binding var timerDone: Bool
    let size: Double
    
    var body: some View {
        TimelineView(
            .animation(minimumInterval: 1.0,paused: timeRemaing <= 0)
        ) { context in
            CountDownView(date: context.date, timeRamaining: $timeRemaing, size: size)
                .onChange(of: timeRemaing) {
                    if timeRemaing < 1 {
                        timerDone = true
                    }
                }
        }
    }
}

#Preview {
    TimerView(timerDone: .constant(false), size: 90)
}
