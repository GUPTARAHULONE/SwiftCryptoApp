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
        private let fileManager = LocalFileManager.instance
        private let folderNames = "coin_images"
    
    
    init(coin : CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderNames) {
            image = savedImage
            print("Retrived")
        } else {
            downloadCoinImage()
            print("Download")
        }
    }

    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
          
          imageSubscription = NetworkManager.download(url: url)
              .tryMap({ (data) -> UIImage? in
                  return UIImage(data: data)
              })
              .receive(on: DispatchQueue.main)
              .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                  guard let self = self, let downloadImage = returnedImage else {return}
                  self.image = downloadImage
                  self.imageSubscription?.cancel()
                  self.fileManager.saveImage(image: downloadImage, imageName: self.coin.id, folderName: self.folderNames)
              })
      }
    
}
