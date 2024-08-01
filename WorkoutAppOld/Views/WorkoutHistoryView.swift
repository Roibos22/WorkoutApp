//
//  WorkoutHistoryView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 20.12.23.
//

import SwiftUI

//extension WorkoutHistoryView {
//    func workouts(for date: Date) -> [CompletedWorkout] {
//        vm.completedWorkoutsFiltered.filter { Calendar.current.isDate($0.ts, inSameDayAs: date) }
//    }
//    
//    func datesInWorkouts() -> [Date] {
//        let dates = vm.completedWorkoutsFiltered.map { removeTime(from: $0.ts) }
//        let uniqueDates = Array(Set(dates))
//        return uniqueDates.sorted().reversed()
//    }
//    
//    func removeTime(from date: Date) -> Date {
//        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
//        return Calendar.current.date(from: components) ?? date
//    }
//}

//struct WorkoutHistoryView: View {
//    
//    @EnvironmentObject var vm: ViewModel
//    var titleForFilter: String?
//    
//    var body: some View {
//        List {
//            ForEach(datesInWorkouts(), id: \.self) { date in
//                Section(header: Text("\(date, formatter: dateFormatter)")) {
//                    ForEach(workouts(for: date)) { workout in
//                        HStack {
//                            Text(timeFormatter.string(from: workout.ts))
//                            Text(workout.workout.title)
//                                .bold()
//                        }
//                    }
//                }
//            }
//        }
//        .navigationTitle("History")
//        .onAppear {
//            vm.filterWorkoutsForHistory(workoutTitle: titleForFilter)
//        }
//    }
//    
//
//    
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }
//    
//    var timeFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//        return formatter
//    }
//}
//
//struct WorkoutHistoryView_Previews: PreviewProvider {
//    static let vm = ViewModel()
//    static var previews: some View {
//        NavigationView {
//            WorkoutHistoryView()
//                .environmentObject(vm)
//        }
//    }
//}
