//
//  UserCreationOnBoardingView.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import SwiftUI
import Observation

struct UserCreationOnBoardingView: View {
    @State var onBoardingStep: Int = 2
    @State var userCreationViewModel: UserCreationOnBoardingViewModel = UserCreationOnBoardingViewModel()

    var body: some View {
        VStack {
            if onBoardingStep == 0 {
                StepZeroView()
            } else if onBoardingStep == 1 {
                StepOneView(userCreationViewModel: userCreationViewModel)
            } else if onBoardingStep == 2 {
                StepTwoView(userCreationViewModel: userCreationViewModel)
            } else {
            }
            OnBoardingBottomBar(userCreationViewModel: userCreationViewModel, stepNb: $onBoardingStep)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onChange(of: userCreationViewModel.userName) {
            print("vm changed: \(userCreationViewModel.userName)")
        }
    }
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
    @Bindable var userCreationViewModel: UserCreationOnBoardingViewModel
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
                    .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(stepNb == 1 && userCreationViewModel.userName.isEmpty == true ? Color.accentColor.gradient.opacity(1.0) : Color.purple.gradient.opacity(0.6)))
                }
                .disabled(stepNb == 1 && userCreationViewModel.userName.isEmpty == true ? true : false)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    OnBoardingBottomBar(userCreationViewModel: UserCreationOnBoardingViewModel(), stepNb: .constant(1))
}

#Preview {
    UserCreationOnBoardingView(userCreationViewModel: UserCreationOnBoardingViewModel())
}

struct StepZeroView: View {
    var body: some View {
        VStack {
            Text("welcomeEx")
                .font(.system(size: 50, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            EmojiesAnimatedCircle()
            Spacer()
            Text("Bienvenue dans ton nouvel assistant de concentration 🙌")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("Nous aimerions en savoir un peu plus sur toi afin de pouvoir te fournir une expérience agréable")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("(Rassures-toi, c'est très rapide et sans engagement)")
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}

#Preview {
    StepZeroView()
}

struct StepOneView: View {
    @Bindable var userCreationViewModel: UserCreationOnBoardingViewModel

    let frameSize: Double = 150.0
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.fill.questionmark")
                .resizable()
                .scaledToFit()
                .frame(width: frameSize, height: frameSize)
                .foregroundStyle(Color.secondary)
            Spacer()
            Text("INFORMATIONS")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .padding(.leading)
            VStack {
                TextField(NSLocalizedString("\(NSLocalizedString("userName", comment: ""))*", comment: ""), text: $userCreationViewModel.userName)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocorrectionDisabled(true)
                DatePicker(NSLocalizedString("birthDate", comment: ""),  selection: $userCreationViewModel.birthDate, in: ...Date.now, displayedComponents: .date)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Material.regular, in: RoundedRectangle(cornerRadius: 15))
            Text("Tes informations restent sécurisées en local. Aucun partage extérieur.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .padding(.horizontal)
                .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}

#Preview {
    StepOneView(userCreationViewModel: UserCreationOnBoardingViewModel())
}

struct StepTwoView: View {
    @Bindable var userCreationViewModel: UserCreationOnBoardingViewModel
    @State var allEmokiesAvailable = emojies
    @State var selectedUseCases: [EmojiRotation] = []

    let frameSize: Double = 150.0
    let corner: Double = 25.0
    let circleSize: Double = 25.0
    
    @State var isSimpleLayout: Bool = false
    @State var isComplexLayout: Bool = false

    var body: some View {
        VStack {
            Text("Aspect de l'application")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .fontWeight(.semibold)
            Spacer()
            VStack {
                HStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: circleSize)
                        .overlay {
                            if isSimpleLayout {
                                Circle()
                                    .frame(width: circleSize * 0.7)
                                    .foregroundStyle(.accent)
                            }
                        }
                    ZStack {
                        RoundedRectangle(cornerRadius: corner)
                            .padding(.leading, 10)
                            .opacity(0.5)
                        Text("Simple layout")
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    isComplexLayout = false
                    isSimpleLayout.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
            .background(Material.regular, in: RoundedRectangle(cornerRadius: corner))
            Divider()
                .padding()
            VStack {
                HStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: circleSize)
                        .overlay {
                            if isComplexLayout {
                                Circle()
                                    .frame(width: circleSize * 0.7)
                                    .foregroundStyle(.accent)
                            }
                        }
                    ZStack {
                        RoundedRectangle(cornerRadius: corner)
                            .padding(.leading, 10)
                            .opacity(0.5)
                        Text("Simple layout")
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    isSimpleLayout = false
                    isComplexLayout.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
            .background(Material.regular, in: RoundedRectangle(cornerRadius: corner))
            Spacer()
            Text("Il existe plusieurs layout. Tu peux en changer à tout moment dans les paramètres de votre application.")
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .padding(.bottom, 30)
        }
        .padding(.horizontal)
    }
}

#Preview {
    StepTwoView(userCreationViewModel: UserCreationOnBoardingViewModel())
}
