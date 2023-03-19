//
//  HomeViewModel.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 19/03/23.
//

import Foundation

class HomeViewModel : ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portFolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portFolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
