//
//  AddDeleteViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation

protocol AddDeleteViewModelProtocol {
    var coinListArray: [CoinModel] { get set  }
    var coinListService: Service { get }

    func fetchItems()

}

protocol AddDeleteViewModelOutput: AnyObject {
    func updateView(valuePostList : [CoinModel])
}

final class AddDeleteViewModel: AddDeleteViewModelProtocol {
    weak var output : AddDeleteViewModelOutput?
    
    let coinListService: Service
    var coinListArray: [CoinModel] = []

    init() {
        coinListService = Service()
    }

    func fetchItems() {
        coinListService.loadCoins { [weak self] response in
            self?.output?.updateView(valuePostList: response ?? [])
        }
    }
}
