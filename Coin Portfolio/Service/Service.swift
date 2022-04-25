//
//  Service.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

class Service {
    
    var collectionViewModel : CollectionViewModel!
    
    func loadCoins(completion : @escaping ([CoinModel]) ->()) {
        let api = "https://api.binance.com/api/v3/ticker/price"
        if let url = URL(string: api) {
    
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode([CoinModel].self, from: safeData)
                        completion(result)
                    } catch {
                         print(error)
                    }
                }
            }
            .resume()
        }
    }
}
