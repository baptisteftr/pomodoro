//
//  UserCreationOnBoardingViewModel.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import Foundation
import Observation

@Observable
class UserCreationOnBoardingViewModel: Observable {
    var userName: String = "Baptiste"
    var birthDate: Date = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? Date()
    var pointsOfInterest: [PointOfInterest] = []
    var onBoardingState: Int = 0
    var isSimpleLayout: Bool = true
    var isComplexLayout: Bool = false
}

struct PointOfInterest: Identifiable {
    var id = UUID()
    var labelName: String
    var labelImage: String
    var format: Int
}

let workPOI = PointOfInterest(labelName: "work", labelImage: "💼", format: 0)
let studyPOI = PointOfInterest(labelName: "study", labelImage: "🎓", format: 0)
let meditationPOI = PointOfInterest(labelName: "meditation", labelImage: "🧘‍♂️", format: 1)
let sportPOI = PointOfInterest(labelName: "sport", labelImage: "🏉", format: 1)

var pois = [workPOI, studyPOI, meditationPOI, sportPOI]

struct EmojiRotation: Identifiable, Equatable {
    var id = UUID()
    var content: String
    var rotationStart: Double // Commence à 0.0 et augmente de 30.0 à chaque item
    var description: String?
}

var emojies: [EmojiRotation] = [
    EmojiRotation(content: "📚", rotationStart: 0.0, description: NSLocalizedString("read", comment: "")),
    EmojiRotation(content: "🧘‍♂️", rotationStart: 30.0, description: NSLocalizedString("meditate", comment: "")),
    EmojiRotation(content: "🏢", rotationStart: 60.0),
    EmojiRotation(content: "💻", rotationStart: 90.0, description: NSLocalizedString("work", comment: "")),
    EmojiRotation(content: "🏉", rotationStart: 120.0, description: NSLocalizedString("sport", comment: "")),
    EmojiRotation(content: "✏️", rotationStart: 150.0, description: NSLocalizedString("draw", comment: "")),
    EmojiRotation(content: "💼", rotationStart: 180.0),
    EmojiRotation(content: "✍️", rotationStart: 210.0, description: NSLocalizedString("write", comment: "")),
    EmojiRotation(content: "💵", rotationStart: 240.0),
    EmojiRotation(content: "🖼️", rotationStart: 270.0, description: NSLocalizedString("paint", comment: "")),
    EmojiRotation(content: "👨‍🍳", rotationStart: 300.0, description: NSLocalizedString("cook", comment: "")),
    EmojiRotation(content: "🏠", rotationStart: 330.0, description: NSLocalizedString("homework", comment: ""))
]
