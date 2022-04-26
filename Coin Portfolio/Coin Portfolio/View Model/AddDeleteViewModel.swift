//
//  AddDeleteViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation

protocol AddDeleteViewModelProtocol {
    func fetchItems()
    
    var coinList: [CoinModel] { get set  }
    var coinListService: Service { get }
}


class AddDeleteViewModel: AddDeleteViewModelProtocol {
    let coinListService: Service
    var coinList: [CoinModel] = []
    
    init() {
        coinListService = Service()
    }
    
    var decodedData = [CoinModel] ()
    
    func numberOfRow() -> Int {
        return decodedData.count
    }
    
    func fetchItems() {
        coinListService.loadCoins { response in
            self.coinList = response ?? []
        }
    }
    
    
    
    
}
