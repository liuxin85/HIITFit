//
//  HistoryView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI

struct HistoryView: View {
    @Binding var showHistory: Bool
    let history = HistoryStore()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Button(action: {showHistory.toggle()}){
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .padding()
            }
            .font(.title)
            .padding(.trailing)
            VStack {
                Text("History")
                    .font(.title)
                    .padding()
                
                Form {
                    ForEach(history.exerciseDays) { day in
                        Section(header: Text(day.date.formatted(as: "MMM d"))
                            .font(.headline)
                        ) {
                            ForEach(day.exercises, id: \.self) { exercise in
                                Text(exercise)
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView(showHistory: .constant(true))
}
