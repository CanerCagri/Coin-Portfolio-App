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
    func fetchSelectedItems(selectedItem : String)
}

protocol TabBarViewModelOutput: AnyObject {
    func updateView(valueCoinList : [CoinModel])
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
    
    func fetchSelectedItems(selectedItem : String) {
        coinListService.loadSelectedCoin(selectedCoin: selectedItem) { [weak self] response in
            self?.output?.updateView(valueCoinList: [response!])
        }
    }
   
    func fetchPostItems() {
        postListService.fetchData {[weak self] response in
            self?.output?.postUpdate(valuePostList: response ?? [])
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
