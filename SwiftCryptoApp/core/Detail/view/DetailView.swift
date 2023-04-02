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
    @State private var showFullDescription = false
    
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
            VStack {
                ChartView(coin : vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    
                    overViewTitle
                    
                    Divider()
                    
                    descriptionText
                    
                    overViewGrid
                    
                    addtionalViewTitle
                    Divider()
                    
                    addtionalViewGrid
                    
                    websiteSection
                   
                    
                }
            }
        
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationTrailingItems
            }
        }
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
    
    private var navigationTrailingItems : some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    
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
    
    private var descriptionText: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            showFullDescription.toggle()
                        }
                    },
                           label: {
                        Text(showFullDescription ? "Less" : "Read More...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)

                }
                .padding(.horizontal,10)
                .frame(width: .infinity, alignment: .leading)
                
            }
        }
    }
    
    private var websiteSection: some View {
        
        VStack(alignment: .leading, spacing: 10){
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website" , destination: url)
            }
                
                if let redditString = vm.redditURL,
                   let url = URL(string: redditString) {
                    Link("Reddit" , destination: url)
                }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity , alignment: .leading)
        .font(.headline)
        
    }
        
}
