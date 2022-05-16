//
//  Constants.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 4.05.2022.
//

import Foundation

struct MainVC {
    let tabBarIdentifier = "toTabBar"
    let signInVcIdentifier = "ToSigninVC"
}

struct AddDeleteVC {
    let title = "Coin List"
    let cellIdentifier = "CoinListCell"
    let symbolSuffixUsdt = "USDT"
    let firstlastPriceFilter = "0.00000000"
    let secondlastPriceFilter = "0.0"
    let lastPriceSeperator = "000"
    let popUpIdentifier = "toPopup"
}

struct AddDeletePopupVC {
    let selectedCoinNameSeperator = "/USDT"
}

struct CollectionVC {
    let cellIdentifier = "Cell"
    let title = "YOUR COIN LIST"
}

struct TabBarC {
    let logoutImageName = "logout"
    let segueIdentifier = "toVC"
}

struct FirestoreConstants {
    let collectionName = "Post"
    let id = "id"
    let email = "email"
    let coinname = "coinname"
    let coinquantity = "coinquantity"
    let totalprice = "totalprice"
    let date = "date"
}

struct CoinApiService {
    let apiUrl = "https://api.binance.com/api/v3/ticker/24hr"
}
