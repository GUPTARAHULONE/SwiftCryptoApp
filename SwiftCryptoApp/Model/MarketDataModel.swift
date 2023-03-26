//
//  MarketDataModel.swift
//  SwiftCryptoApp
//
//  Created by Rahul Gupta on 26/03/23.
//

import Foundation


// JSON data
/*
 
 URL: https://api.coingecko.com/api/v3/global
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 12418,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 643,
     "total_market_cap": {
       "btc": 47091643.76170156,
       "eth": 673784371.6128488,
       "ltc": 12248833651.889223,
       "bch": 8238187786.530771,
       "bnb": 3553446148.0143285,
       "eos": 995371310218.2195,
       "xrp": 2619973974735.766,
       "xlm": 11814112992391.555,
       "link": 157199845830.27127,
       "dot": 170217377734.00992,
       "yfi": 142818704.56615335,
       "usd": 1080134511969.5758,
       "aed": 3967344863809.3647,
       "ars": 199805220865580.8,
       "aud": 1515669590289.4807,
       "bdt": 111633600863642.94,
       "bhd": 407199909667.4094,
       "bmd": 1080134511969.5758,
       "brl": 5480170459928.834,
       "cad": 1445419801900.005,
       "chf": 991446827460.7755,
       "clp": 868266127446743.9,
       "cny": 7327092461945.6,
       "czk": 23583134149239.855,
       "dkk": 7368132172727.8955,
       "eur": 990597841734.3689,
       "gbp": 870673747273.9238,
       "hkd": 8456226195916.155,
       "huf": 384966198365318.2,
       "idr": 16169294939695438,
       "ils": 3673058975619.7188,
       "inr": 88049863999344.98,
       "jpy": 140110368313408.47,
       "krw": 1330994297433321.8,
       "kwd": 329580363502.76385,
       "lkr": 391195926009559.6,
       "mmk": 2256947665622694,
       "mxn": 20320462560232.395,
       "myr": 4585711070566.823,
       "ngn": 489008940079460.2,
       "nok": 10663877480491.895,
       "nzd": 1664396551646.1082,
       "php": 58805228568575.92,
       "pkr": 249096409705960.7,
       "pln": 4672656498107.816,
       "rub": 74545476862772.92,
       "sar": 4054629453587.112,
       "sek": 11056294669228.469,
       "sgd": 1416504601014.5798,
       "thb": 35369004594443.67,
       "try": 20318734345013.23,
       "twd": 32678929592383.453,
       "uah": 39498001309179.914,
       "vef": 108153868683.51349,
       "vnd": 25328517894752604,
       "zar": 18431900292644.688,
       "xdr": 796494429529.8987,
       "xag": 45616780776.75501,
       "xau": 558073098.2993175,
       "bits": 47091643761701.56,
       "sats": 4709164376170156
     },
     "total_volume": {
       "btc": 3858498.374021199,
       "eth": 55207159.7981343,
       "ltc": 1003619771.0284172,
       "bch": 675003708.5148824,
       "bnb": 291154971.2230678,
       "eos": 81556689791.06319,
       "xrp": 214670045765.4727,
       "xlm": 968000522604.7863,
       "link": 12880318058.1643,
       "dot": 13946921847.54389,
       "yfi": 11701985.646049682,
       "usd": 88501842901.2298,
       "aed": 325068153994.6455,
       "ars": 16371229760677.469,
       "aud": 124187821501.3921,
       "bdt": 9146804677240.979,
       "bhd": 33364309755.334545,
       "bmd": 88501842901.2298,
       "brl": 449022950143.679,
       "cad": 118431838642.78204,
       "chf": 81235133584.29543,
       "clp": 71142206416153.6,
       "cny": 600352251320.4908,
       "czk": 1932306403013.4814,
       "dkk": 603714878841.524,
       "eur": 81165571135.77518,
       "gbp": 71339477023.98042,
       "hkd": 692868891823.0913,
       "huf": 31542569589675.984,
       "idr": 1324846474877642.8,
       "ils": 300955561390.6768,
       "inr": 7214448890199.124,
       "jpy": 11480075553456.617,
       "krw": 109056276703058,
       "kwd": 27004478822.609276,
       "lkr": 32053008216697.316,
       "mmk": 184925141753884.8,
       "mxn": 1664976320316.5427,
       "myr": 375734574037.17017,
       "ngn": 40067410042563.57,
       "nok": 873754887968.1007,
       "nzd": 136373905755.9912,
       "php": 4818262024659.3955,
       "pkr": 20409949941196.086,
       "pln": 382858529881.5049,
       "rub": 6107954156817.294,
       "sar": 332219899417.65076,
       "sek": 905907961501.4873,
       "sgd": 116062644308.31616,
       "thb": 2897992845800.7627,
       "try": 1664834717367.9,
       "twd": 2677579006055.2505,
       "uah": 3236306097102.1646,
       "vef": 8861689529.700129,
       "vnd": 2075316071102005.8,
       "zar": 1510235184594.0454,
       "xdr": 65261524460.895355,
       "xag": 3737654080.326179,
       "xau": 45726247.171778135,
       "bits": 3858498374021.199,
       "sats": 385849837402119.94
     },
     "market_cap_percentage": {
       "btc": 40.926766322976206,
       "eth": 17.882201857686102,
       "usdt": 6.225955298672438,
       "usdc": 4.042860057960563,
       "bnb": 3.7963742332937485,
       "xrp": 1.9377750606446575,
       "busd": 1.44271227155835,
       "ada": 1.2139775328987827,
       "doge": 1.095246019640023,
       "sol": 0.8327422558990171
     },
     "market_cap_change_percentage_24h_usd": 2.2325262410016724,
     "updated_at": 1674732457
   }
 }
 */

// MARK: - GlobalData
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        /*
        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
            return key == "usd"
        }) {
            return "\(item.value)"
        }
        */
        
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
