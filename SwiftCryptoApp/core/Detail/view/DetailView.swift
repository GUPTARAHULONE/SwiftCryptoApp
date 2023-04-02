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
    
    @StateObject private var vm : DetailViewModel
    
    let columns : [GridItem ] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print((coin.name))
    }
    
    private let spacing : CGFloat = 30
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                
                
                overViewTitle
                
                Divider()
                overViewGrid
                
                addtionalViewTitle
                Divider()
                
                addtionalViewGrid
               
                
            }
        
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
                   DetailView(coin: dev.coin)
               }
    }
}

extension DetailView {
    
    private var overViewTitle: some View {
        Text("overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity , alignment: .center)
    }
    
    private var addtionalViewTitle: some View {
        Text("Addtional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity , alignment: .center)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .center,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.overviewStatistics) { stats in
                StatisticsView(stat: stats)
            }
        })
    }
    
    private var addtionalViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .center,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.additionalStatistics) { stats in
                StatisticsView(stat: stats)
            }
        })
    }
    
    
        
}
