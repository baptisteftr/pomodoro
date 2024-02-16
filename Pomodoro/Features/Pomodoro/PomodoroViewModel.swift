//
//  PomodoroViewModel.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 15/02/2024.
//

import Foundation

@Observable
class PomodoroViewModel: Observable {
    var pomodoros: [PomodoroTimer] = [PomodoroTimer(name: "test", isPreset: false, duration: 0.0)]
}

struct PomodoroTimer: Identifiable {
    var id = UUID()
    var name: String
    var isPreset: Bool
    var duration: Double
//    var label:
}

//enum ClocksPreset {
//    case pomodoro
//    case timer
//    
//    enum Labels: CaseIterable, Int {
//    }
//}
