//
//  DetailViewModel.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 01/04/23.
//

import Foundation
import Combine


class DetailViewModel : ObservableObject {
    
    private let coinDetailService : CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { (returnedCoins) in
                print(returnedCoins)
            }
            .store(in: &cancellable)
    }
}


