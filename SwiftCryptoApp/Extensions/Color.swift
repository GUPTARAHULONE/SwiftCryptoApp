//
//  Color.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 18/03/23.
//

import Foundation
import SwiftUI


extension Color {
    // static keyword used so that variable can be directly accesible without creating instances.
        static let theme = ColorTheme()
        static let launch = LaunchTheme()
}


struct ColorTheme {
        let accent = Color("AccentColor")
        let background = Color("BackgroundColor")
        let green = Color("GreenColor")
        let red = Color("RedColor")
        let secondaryText = Color("SecondaryTextColor")
}

struct ColorTheme2 {
    
    let accent = Color(.blue)
    let background = Color(.black)
    let green = Color(.green)
    let red = Color(.cyan)
    let secondaryText = Color(.gray)
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
