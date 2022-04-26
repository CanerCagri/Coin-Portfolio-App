//
//  Service.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase
import Alamofire


protocol ServiceProtocol {
    func loadCoins(completion : @escaping ([CoinModel]?) -> Void)
}

class Service: ServiceProtocol {
    
    func loadCoins(completion: @escaping ([CoinModel]?) -> Void) {
        
        let api = "https://api.binance.com/api/v3/ticker/price"
        
        AF.request(api).responseDecodable(of: [CoinModel].self ) { (model) in
            guard let data = model.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
