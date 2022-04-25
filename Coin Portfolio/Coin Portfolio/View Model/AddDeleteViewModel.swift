//
//  AddDeleteViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation

struct AddDeleteViewModel {
    
    var decodedData = [CoinModel] ()
    
    func numberOfRow() -> Int {
        return decodedData.count
    }
}
