//
//  CollectionViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase
import GameController

class CollectionViewModel {
    
    var post = [PostModel] ()
    
    
    func numberOfRow() -> Int {
        return post.count
    }
    
    func fetchData(completion : @escaping ([PostModel]) -> ()) {
        let userEmail = Auth.auth().currentUser?.email
        post.removeAll(keepingCapacity: false)
        Firestore.firestore().collection("Post").order(by: "date" , descending: true)
            .addSnapshotListener { snapshot, err in
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
                                                self.post.append(PostModel(email: email, coinname: coinName, coinquantity: coinquantity, totalprice: totalprice))
                                                completion(self.post)
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
