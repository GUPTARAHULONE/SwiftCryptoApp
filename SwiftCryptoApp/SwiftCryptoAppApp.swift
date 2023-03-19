//
//  SwiftCryptoAppApp.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 18/03/23.
//

import SwiftUI

@main
struct SwiftCryptoAppApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true) 
            }
            .environmentObject(vm)
        }
    }
}
