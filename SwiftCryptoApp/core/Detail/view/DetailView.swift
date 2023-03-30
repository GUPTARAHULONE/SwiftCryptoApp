//
//  DetailView.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 30/03/23.
//

import SwiftUI


struct DetailLoadingView: View {
    
    @Binding var coin : CoinModel?
    
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
}

struct DetailView: View {
    
    let coin : CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: (dev.coin))
    }
}
