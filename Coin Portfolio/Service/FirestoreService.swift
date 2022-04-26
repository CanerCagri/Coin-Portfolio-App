//
//  FirestoreService.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 26.04.2022.
//

import Foundation
import Firebase

protocol FirestoreServiceProtocol {
    func fetchData(completion:@escaping ([PostModel]?) -> Void)
    func addData(selectedCoin : String , selectedCoinPrice: Double, totalPrice: String)
}

class FirestoreService: FirestoreServiceProtocol {
    
    var collectionVM : CollectionViewModel?
    var posts: [PostModel] = []
    
    func addData(selectedCoin : String , selectedCoinPrice: Double, totalPrice: String) {
        let db = Firestore.firestore()
        
        db.collection("Post").addDocument(data: ["email" : Auth.auth().currentUser!.email! , "coinname" : selectedCoin , "coinquantity" : selectedCoinPrice , "totalprice" : totalPrice , "date" : FieldValue.serverTimestamp()]) { error in
            if error == nil {
                
            } else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func fetchData(completion: @escaping ([PostModel]?) -> Void) {
        let userEmail = Auth.auth().currentUser?.email
        Firestore.firestore().collection("Post").order(by: "date" , descending: true)
            .addSnapshotListener {  snapshot, err in
                if err != nil {
                    print(err!.localizedDescription)
                } else {
                    
                    if snapshot?.isEmpty != true && snapshot != nil {
                        
                        for document in snapshot!.documents {
                            
                            if let email = document.get("email") as? String {
                                
                                if email == userEmail {
                                    
                                    if let coinName = document.get("coinname") as? String {
                                        
                                        if let coinquantity = document.get("coinquantity") as? Double {
                                            
                                            if let totalprice = document.get("totalprice") as? String {
                                                self.posts.append(PostModel(email: email, coinname: coinName, coinquantity: coinquantity, totalprice: totalprice))
                                                completion(self.posts)
                                            }
                                        }
                                    }
                                } else {
                                    // If current email and firestore email is not matching , do nothing! go next loop
                                }
                            }
                        }
                    }
                }
            }
    }
}
