//
//  HomeViewModel.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 19/03/23.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portFolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var coinDataService = CoinDataService()
    private var marketDataService = MarketDataService()
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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)  // as map is providing both values based on two publisher  so need pass values in filtercoins fxn.
            .sink { [weak self] (returnedCoins) in
                            self?.allCoins = returnedCoins
            
                }
                .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
            var stats: [StatisticModel] = []
            
            guard let data = marketDataModel else {
                return stats
            }
            
            let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = StatisticModel(title: "24h Volume", value: data.volume)
            let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
            let portfolio = StatisticModel(title: "Portfolio value", value: "$0.0",percentageChange: 0.0)
            
            /*
            let portfolioValue = portfolioCoins.map { (coin) -> Double in
                return coin.currentHoldingsValue
            }
            */
            
//            let portfolioValue =
//                portfolioCoins
//                    .map({ $0.currentHoldingsValue })
//                .reduce(0, +)
//
//            let previousValue =
//                portfolioCoins
//                .map { (coin) -> Double in
//                    let currentValue = coin.currentHoldingsValue
//                    let percentChange = coin.priceChangePercentage24H ?? 0 / 100
//                    let previousValue = currentValue / (1 + percentChange)
//                    return previousValue
//                }
//                .reduce(0, +)
//
//            let percentageChange = ((portfolioValue - previousValue) / previousValue)
//
//            let portfolio = StatisticModel(
//                title: "Portfolio Value",
//                value: portfolioValue.asCurrencyWith2Decimals(),
//                percentageChange: percentageChange)
//
            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
            
            return stats
        }

}
