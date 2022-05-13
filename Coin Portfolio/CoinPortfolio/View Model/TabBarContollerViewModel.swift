//
//  TabBarContollerViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase


protocol TabBarViewModelProtocol: AnyObject {
    
    var coinListService: Service { get }
    var postListService : FetchDataFirestore { get }
    func fetchPostItems()
    func fetchSelectedItems(index: Int, selectedItem : String , selectedItemQuantity : Double)
    func fetchSelectedByName(selectedItem :  String)
}

protocol TabBarViewModelOutput: AnyObject {
    func currentlyTotalPrice(valueLastPrice : [Double])
    func currentlyCoinPrice(valuePostList : [CoinModel])
    func postUpdate(valuePostList : [PostModel])
}

class TabBarControllerViewModel: TabBarViewModelProtocol {
    
    weak var output : TabBarViewModelOutput?

    let coinListService: Service
    let postListService: FetchDataFirestore

    init() {
        coinListService = Service()
        postListService = FetchDataFirestore()
    }
    
    func fetchPostItems() {
        postListService.fetchData {[weak self] response in
            self?.output?.postUpdate(valuePostList: response ?? [])
        }
    }
    
    func fetchSelectedItems(index: Int, selectedItem : String , selectedItemQuantity : Double) {
        coinListService.loadSelectedCoin(selectedCoin: selectedItem, selectedCoinQuantity: selectedItemQuantity) { [weak self] response in
            self?.output?.currentlyTotalPrice(valueLastPrice: [response!])
        }
    }
   
    func fetchSelectedByName(selectedItem : String) {
        coinListService.loadSelectedCoinByName(selectedCoin: selectedItem) {[weak self] response in
            self?.output?.currentlyCoinPrice(valuePostList: response ?? [])
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }catch {
            print("Error when logout")
        }
    }
}
