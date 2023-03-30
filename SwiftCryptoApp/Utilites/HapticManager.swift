//
//  HapticManager.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 30/03/23.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
