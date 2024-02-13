//
//  ContentView.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var users: [User]
    @State var selectedLayout: NavigationLayout = .simple
    var body: some View {
        if users.count == 0 {
            UserCreationOnBoardingView()
        } else {
            Navigation(layout: $selectedLayout)
                .onAppear {
                    if users.count > 0 {
                        withAnimation {
                            selectedLayout = NavigationLayout(rawValue: users[0].selectedLayout) ?? .simple
                        }
                    }
                }
                .onChange(of: users) {
                    if users.count > 0 {
                        withAnimation {
                            selectedLayout = NavigationLayout(rawValue: users[0].selectedLayout) ?? .simple
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
