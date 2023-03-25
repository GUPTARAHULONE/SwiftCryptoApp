//
//  HomeViewModel.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 19/03/23.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portFolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                
            }
            .store(in: &cancellables)
    }

}
