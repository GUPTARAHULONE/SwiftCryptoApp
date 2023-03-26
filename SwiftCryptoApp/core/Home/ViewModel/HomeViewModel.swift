//
//  HomeViewModel.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 19/03/23.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 1.2),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value", percentageChange: -1.2)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portFolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // we are not using this becoz, this service used in the search text ,so that
        // it get subscribing from there no need to again subscribes.
//        dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//
//            }
//            .store(in: &cancellables)
//
        // debounce is used ofr waiting 0.5 sec before calling filter coins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)  // as map is providing both values based on two publisher  so need pass values in filtercoins fxn.
            .sink { [weak self] (returnedCoins) in
                            self?.allCoins = returnedCoins
            
                }
                .store(in: &cancellables)
    }
    
    private func filterCoins(text: String , coins: [CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }

}
