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
    func loadSelectedCoin(selectedCoin : String, selectedCoinQuantity: Double , completion : @escaping (Double?) -> Void)
    func loadSelectedCoinByName(selectedCoin : String, completion : @escaping ([CoinModel]?) -> Void)
}

class Service: ServiceProtocol {
    
    let coinApiConstant = CoinApiService()
    
    func loadCoins(completion: @escaping ([CoinModel]?) -> Void) {
        
        let api = coinApiConstant.apiUrl
        
        AF.request(api).responseDecodable(of: [CoinModel].self ) { (model) in
            guard let data = model.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    func loadSelectedCoin(selectedCoin : String, selectedCoinQuantity: Double , completion : @escaping (Double?) -> Void) {
        let api = "https://api.binance.com/api/v3/ticker/24hr?symbol=\(selectedCoin)USDT"
        
        AF.request(api).responseDecodable(of: CoinModel.self ) { (model) in
            guard let data = model.value else {
                completion(nil)
                return
            }
            let currentlyLastPrice = data.lastPrice
            let result = Double(currentlyLastPrice)! * selectedCoinQuantity
            completion(result)
        }
    }
    
    func loadSelectedCoinByName(selectedCoin : String, completion : @escaping ([CoinModel]?) -> Void) {
        let api = "https://api.binance.com/api/v3/ticker/24hr?symbol=\(selectedCoin)USDT"
        
        AF.request(api).responseDecodable(of: CoinModel.self ) { (model) in
            guard let data = model.value else {
                completion(nil)
                return
            }
            completion([data])
        }
    }
}
