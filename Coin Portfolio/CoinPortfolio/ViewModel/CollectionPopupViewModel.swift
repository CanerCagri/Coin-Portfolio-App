//
//  CollectionPopupViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 13.05.2022.
//

import Foundation
import UIKit

protocol CollectionPopupViewModelProtocol {
    var postListService: UpdateDataFirestore { get }
    func postUpdateDocument(selectedCoinId: String, selectedCoin: String, selectedCoinQuantity: Double, totalPrice: String)
}

class CollectionPopupViewModel: CollectionPopupViewModelProtocol {
    var postListService: UpdateDataFirestore
    
    init() {
        postListService = UpdateDataFirestore()
    }
    
    func postUpdateDocument(selectedCoinId: String, selectedCoin: String, selectedCoinQuantity: Double, totalPrice: String) {
        postListService.updateData(selectedCoinId: selectedCoinId, coinname: selectedCoin, coinquantity: selectedCoinQuantity, totalprice: totalPrice)
    }
}
