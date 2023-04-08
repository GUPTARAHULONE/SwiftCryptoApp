//
//  SettingView.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 08/04/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
        
        let defaultURL = URL(string: "https://www.google.com")!
        let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
        let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
        let coingeckoURL = URL(string: "https://www.coingecko.com")!
        let personalURL = URL(string: "https://github.com/Firozmemon")!
        
        var body: some View {
            NavigationView {
                ZStack {
                    // background
                    Color.theme.background
                        .ignoresSafeArea()
                    
                    // content
                    List {
                        swiftfulThinkingSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                        coinGeckoSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                        developerSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                        applicationSection
                            .listRowBackground(Color.theme.background.opacity(0.5))
                    }
                }
                .font(.headline)
                .tint(.blue)
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        })
                    }
                }
            }
        }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

extension SettingView {
    
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftfulThinking on Youtube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Youtube 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🦎", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Firoz Memon. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 🤙", destination: personalURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
    
}

