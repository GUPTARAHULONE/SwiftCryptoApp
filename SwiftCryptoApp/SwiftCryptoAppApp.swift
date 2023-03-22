//
//  SwiftCryptoAppApp.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 18/03/23.
//

import SwiftUI

@main
struct SwiftCryptoAppApp: App {
    
    // stateObject is used for like environment objects, unlike state is used for local variables.
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
