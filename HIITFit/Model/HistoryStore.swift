//
//  HistoryStore.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import Foundation
import Combine

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}


class HistoryStore: ObservableObject {
   @Published var exerciseDays: [ExerciseDay] = []
    
    init(){
        #if DEBUG
        createDevData()
        #endif
    }
    
    func addDoneExercise(_ exerciseName: String){
        let today = Date()
        if today.isSameDay(as: exerciseDays[0].date) { // 1
        print("Adding \(exerciseName)")
        exerciseDays[0].exercises.append(exerciseName)
        } else {
        exerciseDays.insert( // 2
        ExerciseDay(date: today, exercises: [exerciseName]),
        at: 0)
        }
    }
 
}

extension HistoryStore {
     func createDevData(){
        // Development data
        exerciseDays = [
            ExerciseDay(date: Date().addingTimeInterval(-86400), exercises: [
                Exercise.exercises[0].exerciseName,
                Exercise.exercises[1].exerciseName,
                Exercise.exercises[2].exerciseName
            ]),
            ExerciseDay(date: Date().addingTimeInterval(-86400 * 2),
                exercises: [
                    Exercise.exercises[1].exerciseName,
                    Exercise.exercises[0].exerciseName
                ])
        ]
    }
}
