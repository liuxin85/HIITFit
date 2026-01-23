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
enum FileError: Error {
    case loadFailure
    case saveFailure
}


class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    @Published var loadingError = false
    
    var dataURL: URL {
        URL.documentsDirectory
            .appendingPathComponent("history.plist")
    }
    
    
    init(){
        do {
            try load()
        } catch {
            loadingError = true
        }
    }
    
    func addDoneExercise(_ exerciseName: String){
        let today = Date()
        
        if let firstDay = exerciseDays.first,
           today.isSameDay(as: firstDay.date) {
            
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
            
        } else {
            exerciseDays.insert( // 2
                ExerciseDay(date: today, exercises: [exerciseName]),
                at: 0)
        }
        
        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() throws {
        do {
            guard let data = try? Data(contentsOf: dataURL) else {
                return 
            }
            
            let plistData = try PropertyListSerialization.propertyList(from: data,options: [], format: nil)
            let convertedPlistData = plistData as? [[Any]] ?? []
            
            exerciseDays = convertedPlistData.map {
                ExerciseDay(
                    date: $0[1] as? Date ?? Date(),
                    exercises: $0[2] as? [String] ?? []
                )
            }
            
        } catch {
            throw FileError.loadFailure
        }
    }
    func save() throws {
        let plistData = exerciseDays.map {
            [
                $0.id.uuidString,
                $0.date,
                $0.exercises
            ]
        }
        do {
            let data = try PropertyListSerialization.data (fromPropertyList: plistData, format: .binary, options: .zero)
            try data.write(to: dataURL, options: .atomic)
        }
        catch {
            throw FileError.saveFailure
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
