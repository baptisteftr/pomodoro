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
    @State var timesLeft: Double = 45.0
    @State var startTimer: Bool = false
    @State var translatedDate: String = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundStyle(Color.primary)
                    Clock1minCircleView()
                    Clock5minCircleView()
                    Capsule()
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 90, height: 3)
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
                HStack {
                    Button {
                        timesLeft -= 5.0
                        rotation = valueToDegree(minutes: timesLeft)
                        translatedDate = formatTime(timesLeft)
                    } label: {
                        Image(systemName: "gobackward.5")
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 6)
                            .padding(.top, 5)
                            .background(Color.accentColor, in: Circle())
                    }
                    Text(translatedDate)
                        .animation(nil, value: UUID())
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .frame(width: 100)
                        .background {
                            Capsule()
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .foregroundStyle(.accent)
                        }
                    Button {
                        timesLeft += 5.0
                        rotation = valueToDegree(minutes: timesLeft)
                        translatedDate = formatTime(timesLeft)
                    } label: {
                        Image(systemName: "goforward.5")
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 6)
                            .padding(.top, 5)
                            .background(Color.accentColor, in: Circle())
                    }
                }
                .padding(.bottom)
                Button {
                    rotation = valueToDegree(minutes: timesLeft)
                    startTimer = true
                } label: {
                    Text("Tester la rotation")
                }
            }
            .animation(.linear(duration: startTimer ? 1 : 0), value: rotation)
            .navigationTitle(NSLocalizedString("pomodoro", comment: ""))
            .onReceive(timer, perform: { _ in
                
                if startTimer {
                    timesLeft -= 1/60
                    translatedDate = formatTime(timesLeft)
                    rotation = valueToDegree(minutes: timesLeft)
                    if timesLeft < 0 {
                        rotation = 90
                        startTimer = false
                    }
                }
            })
            .onAppear {
                translatedDate = formatTime(timesLeft)
                rotation = valueToDegree(minutes: timesLeft)
            }
        }
    }
}

func formatTime(_ minutes: Double) -> String {
    let hours = Int(minutes) / 60
    let remainingMinutes = Int(minutes) % 60
    let seconds = Int((minutes - Double(hours * 60 + remainingMinutes)) * 60)
    
    if hours > 0 {
        return "\(hours):\(remainingMinutes):\(seconds)"
    } else {
        return "\(remainingMinutes):\(seconds)"
    }
}

func valueToDegree(minutes: Double) -> Double {
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
