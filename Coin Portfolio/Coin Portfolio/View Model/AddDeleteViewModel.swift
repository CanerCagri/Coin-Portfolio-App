//
//  AddDeleteViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation

protocol AddDeleteViewModelProtocol {
    var coinList: [CoinModel] { get set  }
    var coinListService: Service { get }
    var addDeleteCoinViewControllerProtocol: AddDeleteCoinViewControllerProtocol? { get }
    
    func fetchItems()
    func setDelegate(addDeleteVcProtocol: AddDeleteCoinViewControllerProtocol )
}

final class AddDeleteViewModel: AddDeleteViewModelProtocol {
    var addDeleteCoinViewControllerProtocol: AddDeleteCoinViewControllerProtocol?
    
    let coinListService: Service
    var coinList: [CoinModel] = []
    
    
    init() {
        coinListService = Service()
    }
    
    func setDelegate(addDeleteVcProtocol: AddDeleteCoinViewControllerProtocol) {
        addDeleteCoinViewControllerProtocol = addDeleteVcProtocol
    }
    
    func fetchItems() {
        coinListService.loadCoins { [weak self] response in
            self?.coinList = response ?? []
            self?.addDeleteCoinViewControllerProtocol?.saveDatas(values: self?.coinList ?? [] )
        }
    }
}
