//
//  WorkoutDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 06.10.23.
//

import SwiftUI

struct WorkoutRemoveCard: View {
    
    let workout: Workout
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .offset(x: 15, y: -43)
                .foregroundColor(.gray)
                .bold()
                .font(.subheadline)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.red)
                .frame(height: 60)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
            HStack {
                Spacer()
                Text("Delete Workout")
                Spacer()
            }
            .padding()
            .font(.title2)
            .bold()
        }
        .padding(.vertical, 10)

    }
}

struct WorkoutDetailView: View {
    
    @EnvironmentObject var vm: ViewModel
    let workout: Workout
    let createNew: Bool

    @State private var showDeleteWorkoutAlert: Bool = false
    @State var workoutTitle: String
    
    var body: some View {

            ScrollView {
                VStack {
                    // Button Section
                    WorkoutDetailViewButtonSection(workout: workout)
                        .environmentObject(vm)

                    // Workout Settings
                    WorkoutSettingsSection()
                    
                    // Exercises
                    WorkoutDetailViewExercisesSection(workout: workout)
                    
                    WorkoutRemoveCard(workout: workout)
                        .onTapGesture {
                            showDeleteWorkoutAlert.toggle()
                        }
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()

            }
            .confirmationDialog(
                Text("Delete Workout?"),
                isPresented: $showDeleteWorkoutAlert,
                titleVisibility: .visible
            ) {
                Button(role: .destructive) {
                    withAnimation {
                        vm.delete(workout: workout)
                        //if let tabata = tabataToBeDeleted {
                        //    vm.deleteTabataWithoutIndex(tabata: tabata)
                        //} else {
                            // do nothing
                        //}
                    }
                } label: {
                    Text("Delete")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                        TextField("Workout Title", text: $workoutTitle)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(.title)
                            .bold()
                            .onSubmit {
                                vm.updateWorkoutTitle(workout: workout, title: workoutTitle)
                            }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if createNew == true {
                        vm.addWorkout(workout: workout)
                    }
                }
                
            }
        }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static let myEnvObject = ViewModel()
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(workout: Workout.sampleWorkouts[0], createNew: true, workoutTitle: Workout.sampleWorkouts[0].title)
        }
    }
}
