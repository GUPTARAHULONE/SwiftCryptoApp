//
//  CoinImageService.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 22/03/23.
//

import Foundation
import Combine
import SwiftUI


class CoinImageService {
    @Published var image: UIImage? = nil
        
        private var imageSubscription: AnyCancellable?
        private let coin : CoinModel
    
    init(coin : CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
          
          imageSubscription = NetworkManager.download(url: url)
              .tryMap({ (data) -> UIImage? in
                  return UIImage(data: data)
              })
              .receive(on: DispatchQueue.main)
              .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                  self?.image = returnedImage
                  self?.imageSubscription?.cancel()
              })
      }
    
}
