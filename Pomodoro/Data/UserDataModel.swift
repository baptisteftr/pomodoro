//
//  UserDataModel.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 13/02/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class User {
    var userName: String
    var birthDate: Date
    var selectedLayout: Int // 0 = basic, 1 = complex, 2 = Possible layout payant ?
    
    init(userName: String = "", birthDate: Date = Date(), selectedLayout: Int = 0) {
        self.userName = userName
        self.birthDate = birthDate
        self.selectedLayout = selectedLayout
    }
}
