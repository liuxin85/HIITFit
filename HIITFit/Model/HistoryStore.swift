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
    
    var uniqueExercises: [String] {
        Array(Set(exercises)).sorted(by: <)
    }
    
    func countExercise(exercise: String) -> Int {
        exercises.filter{ $0 == exercise }.count
    }
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
    
    init(preview: Bool = false) {
        do {
            try load()
        } catch {
            loadingError = true
        }
#if DEBUG
        if preview {
            createDevData()
        } else {
            if exerciseDays.isEmpty {
                copyHistoryTestData()
                try? load()
            }
        }
#endif
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
    func addExercis(date: Date, exerciseName: String) {
        let exerciseDay = ExerciseDay(date: date, exercises: [exerciseName])
        
        if let index = exerciseDays.firstIndex(where: { $0.date.yearMonthDay <= date.yearMonthDay}){
            if date.isSameDay(as: exerciseDays[index].date){
                exerciseDays[index].exercises.append(exerciseName)
                
            } else {
                exerciseDays.insert(exerciseDay, at: index)
            }
        } else {
            exerciseDays.append(exerciseDay)
        }
        
        try? save()
    }
}

extension HistoryStore {
  func createDevData() {
    // Development data
    exerciseDays = [
      ExerciseDay(
        date: Date().addingTimeInterval(-86400),
        exercises: [
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[2].exerciseName,
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[0].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 3),
        exercises: [
          Exercise.exercises[2].exerciseName,
          Exercise.exercises[2].exerciseName,
          Exercise.exercises[3].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 4),
        exercises: [
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[1].exerciseName
        ]),
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 5),
        exercises: [
          Exercise.exercises[0].exerciseName,
          Exercise.exercises[1].exerciseName,
          Exercise.exercises[3].exerciseName,
          Exercise.exercises[3].exerciseName
        ])
    ]
  }

  // copy history.plist to Documents directory
  func copyHistoryTestData() {
    let filename = "history.plist"
    if let resourceURL = Bundle.main.resourceURL {
      let sourceURL = resourceURL.appending(component: filename)
      let documentsURL = URL.documentsDirectory
      let destinationURL = documentsURL.appending(component: filename)
      do {
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
      } catch {
        print("Failed to copy", filename)
      }
      print("Sample History data copied to Documents directory")
    }
  }

  // This method creates random test data.
  func createHistoryTestData() {
    print("Data construction started")
    exerciseDays = []
    let numberOfDays: Int = 720
    for day in 0..<numberOfDays {
      guard let date =
        Calendar.current.date(byAdding: .day, value: -day, to: Date())
      else {
        continue
      }
      var exerciseNames: [String] = []
      // repeat a random number of times (max 6) (max 24 exercises)
      // this will result in eg
      // [Squat, Step Up, Burpee, Step Up, Sun Salute, Step Up, Sun Salute]
      for _ in 0..<Int.random(in: 0...5) {
        for exercise in Exercise.exercises where Bool.random() {
          exerciseNames.append(exercise.exerciseName)
        }
      }
      if !exerciseNames.isEmpty {
        exerciseDays.append(
          ExerciseDay(
            date: date,
            exercises: exerciseNames))
      }
    }
    try? save()
    print("Data construction completed")
  }
}
