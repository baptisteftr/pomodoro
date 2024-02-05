//
//  Extensions.swift
//  Pomodoro
//
//  Created by Baptiste Fortier on 04/02/2024.
//

import SwiftUI
import UIKit
import Foundation

extension Color {
    static func fromHex(_ hex: String, alpha: Double = 1.0) -> Color {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedHex = formattedHex.replacingOccurrences(of: "#", with: "")

        var hexValue: UInt64 = 0

        guard Scanner(string: formattedHex).scanHexInt64(&hexValue) else {
            return Color.black // Retourne une couleur par défaut en cas d'échec de conversion
        }

        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0

        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
