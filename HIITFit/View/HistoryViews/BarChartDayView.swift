//
//  BarChartDayView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/26.
//

import SwiftUI
import Charts

struct BarChartDayView: View {
    let day: ExerciseDay
    
    var body: some View {
        Chart {
            ForEach(Exercise.names, id: \.self) { name in
                    BarMark(
                        x: .value(name, name),
                        y: .value("Total Count", day.countExercise(exercise: name)))
             
                    
                    RuleMark(y: .value("Exercise", 1))
                        .foregroundStyle(.red)
                
            }
            
        }
        .padding()
    }
}

#Preview {
    var history = HistoryStore(preview: true)
    
    BarChartDayView(day: history.exerciseDays[0])
        .environmentObject(history)
}
