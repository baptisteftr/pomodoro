//
//  UserCreationOnBoardingViewModel.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import Foundation

class UserCreationOnBoardingViewModel: Observable {
    var firstName: String = ""
    var lastName: String = ""
    var birthDate: String = ""
    var pointsOfInterest: [PointOfInterest] = []
    var onBoardingState: Int = 0
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
