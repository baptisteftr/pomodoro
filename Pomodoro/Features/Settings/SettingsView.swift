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
                                SettingsListRowIcon(iconName: "person")
                                Text("username")
                                Spacer()
                                Text(users[0].userName)
                                    .foregroundStyle(Color.secondary)
                            }
                            Divider()
                            HStack {
                                SettingsListRowIcon(iconName: "birthday.cake")
                                Text("birthdate")
                                Spacer()
                                Text(users[0].birthDate.formatted(.dateTime.day().month(.abbreviated).year()))
                                    .foregroundStyle(Color.secondary)
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
                                    SettingsListRowIcon(iconName: "square.fill.text.grid.1x2")
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
                        Button {
                            modelContext.delete(users[0])
                        } label: {
                            Text("deleteMyData")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 25.0))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                    }
                }
                .padding(.top)
                .navigationTitle("Salut \(users[0].userName) 🎉")
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

struct SettingsListRowIcon: View {
    @State var iconName: String
    @State var color: Color?
    var body: some View {
        Image(systemName: iconName)
            .frame(width: 15)
            .foregroundStyle(color != nil ? color! : Color.primary)
    }
}

#Preview {
    SettingsListRowIcon(iconName: "person")
}
