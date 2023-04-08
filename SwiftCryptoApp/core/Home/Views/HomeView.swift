//
//  HomeView.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 18/03/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPortfolioView: Bool = false // new sheet
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false // new sheet
    @State private var showSettingView: Bool = false // new sheet
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm) // new sheet will be in different env, so need to add this 
                })
            
            VStack {
              HomeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
              columnTiles
                
                if !showPortfolio {
                   allCoinsList
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    allPortFolioList
                }
                Spacer(minLength: 0 )
            }
            .sheet(isPresented: $showSettingView, content: {
                SettingView()
            })
        }
        .background(
        NavigationLink(destination: DetailLoadingView(coin: $selectedCoin),
                       isActive: $showDetailView,
                       label: {EmptyView()})
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .environmentObject(dev.homeVm)
    }
}

extension HomeView {
    private var HomeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingView.toggle()
                    }
                }
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var allPortFolioList: some View {
        List {
            ForEach(vm.portFolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTiles: some View {
        HStack {
            HStack(spacing: 4) {
                           Text("Coin")
                           Image(systemName: "chevron.down")
                               .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0 )
                               .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
                       }
                       .onTapGesture {
                           withAnimation(.default) {
                               vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                           }
                       }
                       
                       
                       Spacer()
                       if showPortfolio {
                           HStack(spacing: 4) {
                               Text("Holdings")
                               Image(systemName: "chevron.down")
                                   .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0 )
                                   .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                           }
                           .onTapGesture {
                               withAnimation(.default) {
                                   vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                               }
                           }
                           
                       }
                       HStack(spacing: 4) {
                           Text("Price")
                           Image(systemName: "chevron.down")
                               .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0 )
                               .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                       }
                       .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                       .onTapGesture {
                           withAnimation(.default) {
                               vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                           }
                       }
                       
                       
                       
                       Button(action: {
                           withAnimation(.linear(duration: 2.0)) {
                               vm.reload()
                           }
                       }, label: {
                           Image(systemName: "goforward")
                       })
                       .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
