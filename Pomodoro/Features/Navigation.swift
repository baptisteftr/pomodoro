//
//  Navigation.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 13/02/2024.
//

import SwiftUI
import SwiftData

struct TabBarObject: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var rootView: AnyView
}

struct Navigation: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @Binding var layout: NavigationLayout
    var body: some View {
        TabView {
            ForEach(layout.tabs) { tab in
                tab.rootView
                    .tabItem {
                        Label(tab.title, systemImage: tab.image)
                    }
            }
        }
    }
}

#Preview {
    Navigation(layout: .constant(.simple))
}
