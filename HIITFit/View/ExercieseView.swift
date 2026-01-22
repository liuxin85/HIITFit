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
    @State private var rating = 0
    @State private var showHistory = false
    @State private var showSuccess = false
    
    let index: Int
    let interval: TimeInterval = 30
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab,titleText: exercise.exerciseName)
                
                VideoPlayerView(videoName: exercise.videoName)
                    .frame(height: geometry.size.height * 0.45)
                
                Text(Date().addingTimeInterval(interval),
                     style: .timer
                )
                .font(.system(size: geometry.size.height * 0.07))
                
                HStack(spacing: 150){
                    startButton
                    doneButton
                        .sheet(isPresented: $showSuccess) {
                            SuccessView(selectedTab: $selectedTab)
                                .presentationDetents([.medium, .large])
                        }
                }
                .font(.title3)
                .padding()
                RatingView(rating: $rating)
                    .padding()
                
                Spacer()
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
        Button("Start Exercise"){}
    }
    var doneButton: some View {
        Button("Done"){
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
}
