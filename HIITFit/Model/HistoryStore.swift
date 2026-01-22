//
//  HistoryStore.swift
//  HIITFit
//
//  Created by liuxin on 2026/1/21.
//

import Foundation

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

struct HistoryStore {
    init(){
        #if DEBUG
        createDevData()
        #endif
    }
    var exerciseDays: [ExerciseDay] = []
}

extension HistoryStore {
    mutating func createDevData(){
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
