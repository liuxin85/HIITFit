//
//  HistoryView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI

struct HistoryView: View {
    @Binding var showHistory: Bool
    @EnvironmentObject var history: HistoryStore
    @State private var addMode = false
    
    var headerView: some View {
        HStack {
            Button { addMode = true } label: {
                Image(systemName: "plus")
            }
            .padding(.trailing)
            EditButton()
            Spacer()
            Text("History")
                .font(.title)
            Spacer()
            Button {
                showHistory.toggle()
            } label: {
                 Image(systemName: "xmark.circle")
            }
        }
    }
    func dayView(day: ExerciseDay) -> some View {
        DisclosureGroup {
            exerciseView(day: day)
                .deleteDisabled(true)
        } label: {
            Text(day.date.formatted(as: "d MMM YYYY"))
                .font(.headline)
        }
      
     }
    
    func exerciseView(day: ExerciseDay) -> some View {
        BarChartDayView(day: day)
    }

    var body: some View {
        VStack {
            if addMode {
                Text("History")
                    .font(.title)
            }else {
                headerView.padding()
            }
         
            List($history.exerciseDays, editActions: [.delete]){ $day in
                dayView(day: day)
            }
            if addMode {
                AddHistoryView(addMode: $addMode)
                    .background(Color.primary.colorInvert())
                    .shadow(color: .primary.opacity(0.5), radius: 7)
            }
        }
        .onDisappear {
            try? history.save()
        }
    }
}

#Preview {
    HistoryView(showHistory: .constant(true))
        .environmentObject(HistoryStore())
}
