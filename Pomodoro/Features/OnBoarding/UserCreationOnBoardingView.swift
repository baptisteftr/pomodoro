//
//  UserCreationOnBoardingView.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import SwiftUI

struct UserCreationOnBoardingView: View {
    @State var onBoardingStep: Int = 0
    var body: some View {
        VStack {
            StepZeroView()
            OnBoardingBottomBar(stepNb: $onBoardingStep)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct StepZeroView: View {
    var body: some View {
        VStack {
            Text("helloEx")
                .font(.system(size: 50, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            EmojiesAnimatedCircle()
            Spacer()
            Text("Bienvenue dans ton nouvel assistant de concentration.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("Avant de commencer, nous aimerions en savoir un peu plus sur toi afin de pouvoir te donner une expérience agréable. 🙌")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Rassures-toi, c'est très rapide et sans engagement")
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    StepZeroView()
}

struct EmojiesAnimatedCircle: View {
    @State var angleProgress: Double = 0.0
    @State var emojieList: [EmojiRotation] = emojies

    let frameSize: Double = 250.0
    var body: some View {
        ZStack {
            ForEach(emojieList.indices, id: \.self) { index in
                ZStack {
                    Text(emojieList[index].content)
                        .rotationEffect(.init(degrees: -angleProgress + Double(index * 30)))
                }
                .frame(width: frameSize, height: frameSize, alignment: .leading)
                .rotationEffect(.init(degrees: -emojieList[index].rotationStart))
            }
        }
        .frame(width: frameSize, height: frameSize, alignment: .leading)
        .rotationEffect(.init(degrees: angleProgress))
        .animation(.linear(duration: 13.0).repeatForever(autoreverses: false), value: angleProgress)
        .onAppear {
            angleProgress += 360
        }
        .onChange(of: angleProgress) {
            for index in emojieList.indices {
                emojieList[index].rotationStart += angleProgress
            }
        }
    }
}

#Preview {
    EmojiesAnimatedCircle()
}

struct OnBoardingBottomBar: View {
    let size: Double = 25
    @Binding var stepNb: Int
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    if stepNb == 0 {
                        stepNb += 1
                    } else {
                        stepNb -= 1
                    }
                }
            } label: {
                HStack {
                    if stepNb == 0 {
                        Text("letsStartInt")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: size * 3)
                    } else {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.white)
                            .frame(width: size, height: size)
                            .frame(width: size * 3, height: size * 3)
                    }
                }
                .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.purple.gradient.opacity(0.6)))
            }
            if stepNb != 0 {
                if stepNb < 3 {
                    Spacer()
                    Text(String(format: NSLocalizedString("stepX", comment: ""), String(stepNb)))
                        .fontWeight(.bold)
                    Spacer()
                }
                Button {
                    withAnimation {
                        stepNb += 1
                    }
                } label: {
                    HStack {
                        if stepNb >= 3 {
                            Text("createMyProfile")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: size * 3)
                        } else {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.white)
                                .frame(width: size, height: size)
                                .frame(width: size * 3, height: size * 3)
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.purple.gradient.opacity(0.6)))
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    OnBoardingBottomBar(stepNb: .constant(1))
}

#Preview {
    UserCreationOnBoardingView()
}
