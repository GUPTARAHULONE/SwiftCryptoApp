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
    
    @Published var isLoading: Bool = false
    
    @Published var sortOption : SortOption = .holdings
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    private let portfolioDataService = PortfolioDataService()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed , price , priceReversed
    }
    
    
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
        // update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)  // as map is providing both values based on two publisher  so need pass values in filtercoins fxn.
            .sink { [weak self] (returnedCoins) in
                            self?.allCoins = returnedCoins
            
                }
                .store(in: &cancellables)
        
        // updates market data
        marketDataService.$marketData
            .combineLatest($portFolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
                }
                .store(in: &cancellables)
        
        // update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
//            .map { (CoinModels, portFolioEntities) -> [CoinModel] in
//                CoinModels
//                    .compactMap { (coin) -> CoinModel? in
//                        guard let entity = portFolioEntities.first(where: {$0.coinId == coin.id }) else {
//                            return nil
//                        }
//                        return coin.updateHoldeings(amount: entity.amount)
//
//                    }
//            }
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portFolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
    }
    
    func updatePortfolio(coin: CoinModel , amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reload() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String , coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        
     var updatedCoins = filterCoins(text: text, coins: coins)
         sortCoins(sort: sort, coins: &updatedCoins)
        
        return updatedCoins
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
    
    // inout is used here so that same coins array will be used for sorting
    
    private func sortCoins(sort : SortOption , coins: inout [CoinModel]) {
        switch sort {
                case .rank, .holdings:
                    coins.sort(by: { $0.rank < $1.rank })
                    /*return coins.sorted { (coin1, coin2) -> Bool in
                        return coin1.rank < coin2.rank
                    }*/
                case .rankReversed, .holdingsReversed:
                    coins.sort(by: { $0.rank > $1.rank })
                case .price:
                    coins.sort(by: { $0.currentPrice > $1.currentPrice })
                case .priceReversed:
                    coins.sort(by: { $0.currentPrice < $1.currentPrice })
                }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
         // will only sort by holdings or reversedholdings if needed
         switch sortOption {
         case .holdings:
             return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
         case .holdingsReversed:
             return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
         default:
             return coins
         }
     }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portFolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portFolioEntities.first(where: {$0.coinId == coin.id }) else {
                    return nil
                }
                return coin.updateHoldeings(amount: entity.amount)
                
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins : [CoinModel]) -> [StatisticModel] {
            var stats: [StatisticModel] = []
            
            guard let data = marketDataModel else {
                return stats
            }
            
            let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = StatisticModel(title: "24h Volume", value: data.volume)
            let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
            
            /*
            let portfolioValue = portfolioCoins.map { (coin) -> Double in
                return coin.currentHoldingsValue
            }
            */
            
            let portfolioValue =
                portfolioCoins
                    .map({ $0.currentHoldingsValue })
                .reduce(0, +)

            let previousValue =
                portfolioCoins
                .map { (coin) -> Double in
                    let currentValue = coin.currentHoldingsValue
                    let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                    let previousValue = currentValue / (1 + percentChange)
                    return previousValue
                }
                .reduce(0, +)

            let percentageChange = ((portfolioValue - previousValue) / previousValue)

            let portfolio = StatisticModel(
                title: "Portfolio Value",
                value: portfolioValue.asCurrencyWith2Decimals(),
                percentageChange: percentageChange)

            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
            
            return stats
        }

}
