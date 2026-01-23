//
//  ExercieseView.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import SwiftUI
import AVKit

struct ExercieseView: View {
    @Binding var selectedTab: Int

    @State private var showHistory = false
    @State private var showSuccess = false
    
    let index: Int
    @State private var timerDone = false
    @State private var showTimer = false
    @EnvironmentObject var history: HistoryStore
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab,titleText: exercise.exerciseName)
                
                VideoPlayerView(videoName: exercise.videoName)
                    .frame(height: geometry.size.height * 0.45)
      
                
                HStack(spacing: 150){
                    startButton
                    doneButton
                        .disabled(!timerDone)
                        .sheet(isPresented: $showSuccess) {
                            SuccessView(selectedTab: $selectedTab)
                                .presentationDetents([.medium, .large])
                        }
                }
                .font(.title3)
                .padding()
                
                
                if showTimer {
                    TimerView(timerDone: $timerDone,
                    size: geometry.size.height * 0.07)
                }
                Spacer()
                
                RatingView(exerciseIndex: index)
                    .padding()
                
              
                Button("History") {
                    showHistory.toggle()
                }
                .sheet(isPresented: $showHistory, content: {
                    HistoryView(showHistory: $showHistory)
                })
                    .padding(.bottom)
            }
        }
    
    }
    var exercise: Exercise {
        Exercise.exercises[index]
    }
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count
    }
    var startButton: some View {
        Button("Start Exercise"){
            showTimer.toggle()
        }
    }
    var doneButton: some View {
        Button("Done"){
            history.addDoneExercise(Exercise.exercises[index].exerciseName)
            timerDone = false
            showTimer.toggle()
            if lastExercise {
                showSuccess.toggle()
            } else {
                selectedTab += 1
            }
        }
    }
}



#Preview {
    ExercieseView(selectedTab: .constant(3), index: 3)
        .environmentObject(HistoryStore())
}
