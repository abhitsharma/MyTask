//
//  MyTaskApp.swift
//  MyTask
//
//  Created by Abhit Sharma on 13/09/25.
//

import SwiftUI

@main
struct MyTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView() 
        }
    }
}
