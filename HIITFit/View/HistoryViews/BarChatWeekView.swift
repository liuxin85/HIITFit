//
//  BarChatWeekView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/26.
//

import SwiftUI
import Charts

struct BarChatWeekView: View {
    @EnvironmentObject var history: HistoryStore
    @State private var weekData: [ExerciseDay] = []
    
    var body: some View {
        // Crate bar chart here
        Chart(weekData){ day in
            ForEach(Exercise.names, id: \.self) { name in
                BarMark(
                    x: .value("Date", day.date, unit: .day) , y: .value("Total Count", day.countExercise(exercise: name)))
                .foregroundStyle(by: .value("Exercise", name))
            }
         
        }
        .onAppear {
            let firstDate = history.exerciseDays.first?.date ?? Date()
            
            let dates = firstDate.previousSevenDays
            
            weekData = dates.map { date in
                history.exerciseDays.first(where: {$0.date.isSameDay(as: date)}) ?? ExerciseDay(date: date)
            }
            
            
        }
       
    }
}

#Preview {
    BarChatWeekView()
        .environmentObject(HistoryStore(preview: true))
}
