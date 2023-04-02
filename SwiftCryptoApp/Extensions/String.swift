//
//  String.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 02/04/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
