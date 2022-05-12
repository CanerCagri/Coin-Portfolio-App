//
//  AddPopupViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

protocol AddPopupViewModelProtocol {
  
    var postListService: AddDataFirestore { get }
    func postAddDocument(selectedCoin: String, selectedCoinPrice: Double, totalPrice: String)
}

class AddPopupViewModel: AddPopupViewModelProtocol{
    let postListService: AddDataFirestore
    
    init() {
        postListService = AddDataFirestore()
    }
    func postAddDocument(selectedCoin: String, selectedCoinPrice: Double, totalPrice: String) {
        postListService.addData(selectedCoin: selectedCoin, selectedCoinPrice: selectedCoinPrice, totalPrice: totalPrice)
    }
}
