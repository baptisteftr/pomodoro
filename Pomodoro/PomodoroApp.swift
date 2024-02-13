//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import SwiftUI
import SwiftData

@main
struct PomodoroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
