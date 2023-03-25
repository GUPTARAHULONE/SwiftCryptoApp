//
//  UiApplication.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 25/03/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
