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
    
    let workout: Workout
    @State private var showDeleteWorkoutAlert: Bool = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {

            ScrollView {
                VStack {
                    
                    // Button Section
                    WorkoutDetailViewButtonSection(workout: workout)

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
                .navigationTitle(workout.title)
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
            }
        }

}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout.sampleWorkouts[0])
    }
}
