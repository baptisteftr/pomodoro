//
//  NavigationRules.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 13/02/2024.
//

import Foundation
import SwiftUI
import SwiftData

enum NavigationLayout: Int, CaseIterable {
    case simple = 0
    case complex = 1
    
    var tabs: [TabBarObject] {
        switch self {
        case .simple:
            return simpleLayout
        case .complex:
            return complexLayout
        }
    }
    
    var displayName: String {
        switch self {
        case .simple:
            return NSLocalizedString("simpleLayout", comment: "")
        case .complex:
            return NSLocalizedString("complexLayout", comment: "")
        }
    }
}

var simpleLayout: [TabBarObject] = [
    TabBarObject(title: "Pomodoro", image: "timer", rootView: AnyView(Text("Pomodoro"))),
    TabBarObject(title: "Paramètres", image: "gear", rootView: AnyView(SettingsView()))
]

var complexLayout: [TabBarObject] = [
    TabBarObject(title: "Pomodoro", image: "timer", rootView: AnyView(Text("Pomodoro"))),
    TabBarObject(title: "Projets", image: "folder", rootView: AnyView(Text("Projets"))),
    TabBarObject(title: "Timers", image: "alarm", rootView: AnyView(Text("Timers"))),
    TabBarObject(title: "Paramètres", image: "gear", rootView: AnyView(SettingsView()))
]
