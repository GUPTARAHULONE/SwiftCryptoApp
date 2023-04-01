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
    
    @StateObject var vm : DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print((coin.name))
    }
    
    var body: some View {
        Text("Hello")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: (dev.coin))
    }
}
