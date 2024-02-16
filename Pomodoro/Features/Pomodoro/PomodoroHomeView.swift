//
//  PomodoroHomeView.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 15/02/2024.
//

import SwiftUI

struct PomodoroHomeView: View {
    @State var pomodoroViewModel: PomodoroViewModel = PomodoroViewModel()
    @State var rotation: Double = 90.0
    @State var timesLeft: Double = 0.0
    @State var startTimer: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Clock1minCircleView()
                    Clock5minCircleView()
                    Circle()
                        .foregroundStyle(Color.primary.opacity(0.1))
                    Capsule()
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 90, height: 5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .rotationEffect(.init(degrees: rotation))
                        .shadow(color: Color.accentColor, radius: 2)
                    Circle()
                        .foregroundStyle(Color.gray)
                        .frame(width: 30)
                        .shadow(radius: 5)
                    Circle()
                        .frame(width: 10)
                        .shadow(radius: 5)
                }
                .frame(width: 200, height: 200, alignment: .center)
                Button {
                    timesLeft = 45
                    rotation = valueToDegree(minutes: timesLeft, totalTime: 45)
                } label: {
                    Text("Tester la rotatio sans anim")
                }
                Button {
                    timesLeft = 45
                    rotation = valueToDegree(minutes: timesLeft, totalTime: 45)
                    startTimer = true
                } label: {
                    Text("Tester la rotation")
                }
            }
            .animation(.linear(duration: startTimer ? 1 : 0), value: rotation)
            .navigationTitle(NSLocalizedString("pomodoro", comment: ""))
            .onReceive(timer, perform: { _ in
                
                if startTimer {
                    timesLeft -= 1
                    rotation = valueToDegree(minutes: timesLeft, totalTime: 45)
                }
                if timesLeft < 0 {
                    rotation = 90
                    startTimer = false
                }
            })
        }
    }
}

func valueToDegree(minutes: Double, totalTime: Double) -> Double {
    let angle = (minutes / 60) * 360.0 + 90
    
    return angle
}

struct Clock1minCircleView: View {
    let rotateOf = 360.0 / 60
    
    var body: some View {
        ZStack {
            ForEach(1...60, id: \.self) { multiplyBy in
                Rectangle()
                    .foregroundStyle(Color.secondary)
                    .frame(width: 7, height: 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .rotationEffect(.init(degrees: Double(multiplyBy) * rotateOf))
            }
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
}

struct Clock5minCircleView: View {
    let rotateOf = 360.0 / 12
    
    var body: some View {
        ZStack {
            ForEach(1...12, id: \.self) { multiplyBy in
                Rectangle()
                    .foregroundStyle(Color.primary)
                    .frame(width: 10, height: 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .rotationEffect(.init(degrees: Double(multiplyBy) * rotateOf))
            }
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
}

#Preview {
    PomodoroHomeView()
}
