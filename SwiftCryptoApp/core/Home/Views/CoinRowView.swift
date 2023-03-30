//
//  CoinRowView.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 19/03/23.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingColumn : Bool
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            
            if showHoldingColumn {
               centreColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
        // added becoz need to make clickable the whole row , spaceer btw made to colored
        .background(
            Color.theme.background
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin,showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin,showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)

        }
    }
}


extension CoinRowView {
    
    private var leftColumn : some View {
        HStack(spacing: 0) {
            //making int to string using backslash
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centreColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0
                    ? Color.theme.green
                    : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width/3.5 , alignment: .trailing)
    }

}
