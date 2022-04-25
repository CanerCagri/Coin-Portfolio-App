//
//  AddPopupViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

class AddPopupViewModel {
    
    func addData(selectedCoin : String , selectedCoinPrice: Double, totalPrice: String) {
        let db = Firestore.firestore()
        
        db.collection("Post").addDocument(data: ["email" : Auth.auth().currentUser!.email! , "coinname" : selectedCoin , "coinquantity" : selectedCoinPrice , "totalprice" : totalPrice , "date" : FieldValue.serverTimestamp()]) { error in
            if error == nil {
                
            } else {
                fatalError(error!.localizedDescription)
            }
        }
    }
}
