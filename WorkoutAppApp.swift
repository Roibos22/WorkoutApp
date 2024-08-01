//
//  WorkoutAppApp.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import SwiftUI

@main
struct WorkoutAppApp: App {
    
   // @StateObject private var vm: ViewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            //WorkoutListView()
              //  .environmentObject(vm)
        }
    }
}

struct Previews_WorkoutAppApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
