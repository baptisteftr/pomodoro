//
//  SettingsView.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 13/02/2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @State var selectedLayout: NavigationLayout = .simple
    let corner: Double = 25.0
    var body: some View {
        NavigationStack {
            if users.count > 0 {
                ScrollView {
                    VStack(spacing: 2) {
                        ScrollViewSectionTitle(title: NSLocalizedString("informations", comment: ""))
                        VStack {
                            HStack {
                                Image(systemName: "person")
                                Text("username")
                                Spacer()
                                Text(users[0].userName)
                            }
                            Divider()
                            HStack {
                                Image(systemName: "birthday.cake")
                                Text("birthdate")
                                Spacer()
                                Text(users[0].birthDate.formatted(.dateTime.day().month(.abbreviated).year()))
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: corner))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        ScrollViewSectionTitle(title: NSLocalizedString("display", comment: ""))
                        VStack {
                            Menu {
                                ForEach(NavigationLayout.allCases, id: \.self) { layout in
                                    Button {
                                        withAnimation {
                                            selectedLayout = layout
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: "square.fill.text.grid.1x2")
                                            Text(layout.displayName)
                                            if layout.rawValue == selectedLayout.rawValue {
                                                Spacer()
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("layout")
                                        .foregroundStyle(Color.primary)
                                    Spacer()
                                    Text(selectedLayout.displayName)
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: corner))
                        .padding(.horizontal)
                        Text("La date de naissance: \(users[0].birthDate.formatted())")
                    }
                }
                .navigationTitle("Salut \(users[0].userName)")
                .onAppear {
                    selectedLayout = NavigationLayout(rawValue: users[0].selectedLayout) ?? .simple
                }
            } else {
                Text("noUserFound")
            }
        }
    }
}

#Preview {
    SettingsView()
}

struct ScrollViewSectionTitle: View {
    @State var title: String
    
    var body: some View {
        Text(title)
            .textCase(.uppercase)
            .font(.footnote)
            .foregroundStyle(Color.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.horizontal)
    }
}

#Preview {
    ScrollViewSectionTitle(title: "sectionTitle")
}
