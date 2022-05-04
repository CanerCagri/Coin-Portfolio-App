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
    func deleteData(selectedCoin : String)
}

class FirestoreService: FirestoreServiceProtocol {
    
    var collectionVM : CollectionViewModel?
    var posts: [PostModel] = []
    let db = Firestore.firestore()
    
    let firestoreConstants = FirestoreConstants()
    
    func deleteData(selectedCoin : String) {
        db.collection(firestoreConstants.collectionName).whereField(firestoreConstants.id, isEqualTo: "\(selectedCoin)").getDocuments { (snapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        self.db.collection(self.firestoreConstants.collectionName).document(document.documentID).delete()
                    }
                }
            }
        }
    }
    
    func addData(selectedCoin : String , selectedCoinPrice: Double, totalPrice: String) {
        db.collection(firestoreConstants.collectionName).addDocument(data: [firestoreConstants.id: UUID().uuidString , firestoreConstants.email: Auth.auth().currentUser!.email! , firestoreConstants.coinname: selectedCoin , firestoreConstants.coinquantity : selectedCoinPrice , firestoreConstants.totalprice : totalPrice , firestoreConstants.date: FieldValue.serverTimestamp()]) { error in
            if error == nil {
                return
            } else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func fetchData(completion: @escaping ([PostModel]?) -> Void) {
        let userEmail = Auth.auth().currentUser?.email
        
        
        Firestore.firestore().collection(firestoreConstants.collectionName).getDocuments(completion: {  snapshot, err in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.posts.removeAll()
                    for document in snapshot!.documents {
                        
                        if let email = document.get(self.firestoreConstants.email) as? String {
                            
                            if email == userEmail {
                                
                                if let coinName = document.get(self.firestoreConstants.coinname) as? String {
                                    
                                    if let coinquantity = document.get(self.firestoreConstants.coinquantity) as? Double {
                                        
                                        if let id = document.get(self.firestoreConstants.id) as? String {
                                            
                                            if let totalprice = document.get(self.firestoreConstants.totalprice) as? String {
                                                self.posts.append(PostModel(id: id, email: email, coinname: coinName, coinquantity: coinquantity, totalprice: totalprice))
                                                completion(self.posts)
                                            }
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
        })
    }
}
